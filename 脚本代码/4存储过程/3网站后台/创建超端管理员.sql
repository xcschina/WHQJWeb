----------------------------------------------------------------------
-- 时间：2018-01-18
-- 用途：后台添加超级客户端用户
----------------------------------------------------------------------
USE WHQJAccountsDB
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_AddSuperUser]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_AddSuperUser]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PM_AddSuperUser]
(
	@strAccounts			NVARCHAR(32),			--用户名
	@strLogonPass    	NVARCHAR(32),			-- 登录密码
  @dwGrantGold      INT,              -- 赠送携带金币
	@strErrorDescribe NVARCHAR(127) OUTPUT		--输出信息
)

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @UserID INT  -- 用户标识

BEGIN
	-- 超端管理员信息
	INSERT INTO [dbo].[AccountsInfo]
      ([Accounts],[NickName],[RegAccounts],[LogonPass],[InsurePass],[UserRight],[MasterRight],[ServiceRight],[MasterOrder]
		  ,[LastLogonIP],[LastLogonDate],[RegisterIP],[RegisterDate],[RegisterOrigin])
  VALUES
      (@strAccounts,@strAccounts,@strAccounts,@strLogonPass,@strLogonPass,536870912,184549632,0,9,
      N'',GETDATE(),N'',GETDATE(),0)

	SELECT @UserID = SCOPE_IDENTITY()

  DECLARE @GameID INT -- 游戏标识

  -- 分配标识
	SELECT @GameID=GameID FROM GameIdentifier WITH(NOLOCK) WHERE UserID=@UserID
	IF @GameID IS NULL
	BEGIN
		SET @GameID=0
		SET @strErrorDescribe=N'注册成功，请联系管理员分配ID ！'
	END
	ELSE
	BEGIN
		UPDATE AccountsInfo SET GameID=@GameID WHERE UserID=@UserID
	END

  IF @dwGrantGold>0
  BEGIN
    BEGIN TRAN

    INSERT WHQJTreasureDB.DBO.GameScoreInfo (UserID,Score) VALUES (@UserID,@dwGrantGold)
    -- 写入赠送记录
    INSERT INTO WHQJRecordDB.dbo.RecordGrantTreasure(MasterID,ClientIP,CollectDate,UserID,CurGold,AddGold,Reason) VALUES(1,'0.0.0.0',GETDATE(),@UserID,0,@dwGrantGold,N'添加超管附赠携带金币')
    -- 写入流水记录
    INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial(SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
    VALUES(dbo.WF_GetSerialNumber(),1,@UserID,0,0,0,@dwGrantGold,'0.0.0.0',GETDATE())

    COMMIT TRAN
  END

	-- 设置用户
	IF @@ERROR=0
	BEGIN
		SET @strErrorDescribe=N'恭喜您！超端管理员创建成功。'
		RETURN 0
	END
	ELSE
	BEGIN
		SET @strErrorDescribe=N'抱歉，超端管理员创建失败。'
		RETURN 2003
	END
END
GO
