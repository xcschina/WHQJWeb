----------------------------------------------------------------------
-- ʱ�䣺2018-01-18
-- ��;����̨��ӳ����ͻ����û�
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
	@strAccounts			NVARCHAR(32),			--�û���
	@strLogonPass    	NVARCHAR(32),			-- ��¼����
  @dwGrantGold      INT,              -- ����Я�����
	@strErrorDescribe NVARCHAR(127) OUTPUT		--�����Ϣ
)

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

DECLARE @UserID INT  -- �û���ʶ

BEGIN
	-- ���˹���Ա��Ϣ
	INSERT INTO [dbo].[AccountsInfo]
      ([Accounts],[NickName],[RegAccounts],[LogonPass],[InsurePass],[UserRight],[MasterRight],[ServiceRight],[MasterOrder]
		  ,[LastLogonIP],[LastLogonDate],[RegisterIP],[RegisterDate],[RegisterOrigin])
  VALUES
      (@strAccounts,@strAccounts,@strAccounts,@strLogonPass,@strLogonPass,536870912,184549632,0,9,
      N'',GETDATE(),N'',GETDATE(),0)

	SELECT @UserID = SCOPE_IDENTITY()

  DECLARE @GameID INT -- ��Ϸ��ʶ

  -- �����ʶ
	SELECT @GameID=GameID FROM GameIdentifier WITH(NOLOCK) WHERE UserID=@UserID
	IF @GameID IS NULL
	BEGIN
		SET @GameID=0
		SET @strErrorDescribe=N'ע��ɹ�������ϵ����Ա����ID ��'
	END
	ELSE
	BEGIN
		UPDATE AccountsInfo SET GameID=@GameID WHERE UserID=@UserID
	END

  IF @dwGrantGold>0
  BEGIN
    BEGIN TRAN

    INSERT WHQJTreasureDB.DBO.GameScoreInfo (UserID,Score) VALUES (@UserID,@dwGrantGold)
    -- д�����ͼ�¼
    INSERT INTO WHQJRecordDB.dbo.RecordGrantTreasure(MasterID,ClientIP,CollectDate,UserID,CurGold,AddGold,Reason) VALUES(1,'0.0.0.0',GETDATE(),@UserID,0,@dwGrantGold,N'��ӳ��ܸ���Я�����')
    -- д����ˮ��¼
    INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial(SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
    VALUES(dbo.WF_GetSerialNumber(),1,@UserID,0,0,0,@dwGrantGold,'0.0.0.0',GETDATE())

    COMMIT TRAN
  END

	-- �����û�
	IF @@ERROR=0
	BEGIN
		SET @strErrorDescribe=N'��ϲ�������˹���Ա�����ɹ���'
		RETURN 0
	END
	ELSE
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�����˹���Ա����ʧ�ܡ�'
		RETURN 2003
	END
END
GO
