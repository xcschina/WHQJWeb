----------------------------------------------------------------------
-- �汾��2013
-- ʱ�䣺2013-04-22
-- ��;����ȡ��Ч���ѽ���
----------------------------------------------------------------------
USE [WHQJTreasureDB]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PJ_ReceiveSpreadAward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PJ_ReceiveSpreadAward]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PJ_ReceiveSpreadAward]
	@UserID		INT,
	@ConfigID   INT,
	@strClientIP NVARCHAR(15),
	@strErrorDescribe NVARCHAR(127) OUTPUT
WITH ENCRYPTION AS

-- ��������
DECLARE @Nullity TINYINT
DECLARE @Count INT
DECLARE @FriendCount INT
DECLARE @SpreadNum INT
DECLARE @PresentDiamond INT
DECLARE @PresentPropID INT
DECLARE @PresentPropName NVARCHAR(32)
DECLARE @PresentPropNum INT
DECLARE @GoodsID INT
DECLARE @CurrentDiamond BIGINT
DECLARE @DateTime DATETIME

-- ִ���߼�
BEGIN
	SET @DateTime = GETDATE()
	-- ��ȡ�û���Ϣ
	SELECT @Nullity=Nullity FROM WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID=@UserID
	IF @Nullity IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ȡ�û�������'
		RETURN 1001
	END
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ȡ�û��Ѷ���'
		RETURN 1002
	END

	-- ��ȡ������Ϣ
	SELECT @SpreadNum=SpreadNum,@PresentDiamond=PresentDiamond,@PresentPropID=PresentPropID,@PresentPropName=PresentPropName,@PresentPropNum=PresentPropNum FROM SpreadConfig WITH(NOLOCK) WHERE ConfigID=@ConfigID
	IF @SpreadNum IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��������Ϣ������'
		RETURN 2001
	END

	-- ��ȡ��Ϸ��������
	SELECT @Count=StatusValue FROM WHQJAccountsDB.dbo.SystemStatusInfo WITH(NOLOCK) WHERE StatusName=N'JJEffectiveFriendGame'
	IF @Count IS NULL OR @Count<0
	BEGIN
		SET @Count=1
	END

	-- ��ȡ��Ч����
	SELECT @FriendCount = COUNT(UserID) FROM (SELECT z.UserID AS UserID,COUNT(z.UserID) AS UCount,COUNT(x.UserID) AS JCount FROM WHQJPlatformDB.dbo.PersonalRoomScoreInfo(NOLOCK) AS z,WHQJTreasureDB.dbo.RecordDrawScoreForWeb(NOLOCK) x
	WHERE z.UserID=x.UserID AND z.UserID IN (SELECT UserID FROM WHQJAccountsDB.DBO.AccountsInfo WITH(NOLOCK) WHERE SpreaderID = @UserID) GROUP BY z.UserID HAVING COUNT(x.UserID)+COUNT(z.UserID)>@Count) AS P

	-- �ж���Ч����
	IF @FriendCount<@SpreadNum
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ȡ�û���Ч����������'
		RETURN 2001
	END

	-- ��������
	BEGIN TRAN

	SELECT @CurrentDiamond=Diamond FROM UserCurrency WITH(ROWLOCK) WHERE UserID=@UserID
	IF @CurrentDiamond IS NULL
	BEGIN
		SET @CurrentDiamond = 0
		INSERT INTO UserCurrency VALUES(@UserID,0)
	END
	IF EXISTS(SELECT RecordID FROM RecordSpreadAward WHERE UserID=@UserID AND ConfigID=@ConfigID)
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ȡ�û��Ѿ���ȡ������'
		ROLLBACK TRAN
		RETURN 2002
	END

	-- ������ʯ
	UPDATE UserCurrency SET Diamond = Diamond + @PresentDiamond WHERE UserID = @UserID
	IF @@ROWCOUNT<=0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ȡ�쳣�����Ժ�����'
		ROLLBACK TRAN
		RETURN 2003
	END

	-- д���¼
	INSERT INTO RecordSpreadAward(UserID,UserNum,ConfigID,SpreadNum,CurrentDiamond,PresentDiamond,PresentPropID,PresentPropName,PresentPropNum,ClientIP,CollectDate) 
	VALUES(@UserID,@FriendCount,@ConfigID,@SpreadNum,@CurrentDiamond,@PresentDiamond,@PresentPropID,@PresentPropName,@PresentPropNum,@strClientIP,GETDATE())
	IF @@ROWCOUNT<=0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ȡ�쳣�����Ժ�����'
		ROLLBACK TRAN
		RETURN 2004
	END

	COMMIT TRAN

	-- ���͵���
	SELECT @GoodsID=GoodsID FROM WHQJAccountsDB.dbo.AccountsPackage WHERE UserID=@UserID AND GoodsID=@PresentPropID
	IF @GoodsID IS NULL
	BEGIN
		INSERT INTO WHQJAccountsDB.dbo.AccountsPackage(UserID,GoodsID,GoodShowID,GoodsSortID,GoodsCount,PushTime) 
		VALUES(@UserID,@PresentPropID,0,0,@PresentPropNum,@DateTime)
	END
	ELSE
	BEGIN
		UPDATE WHQJAccountsDB.dbo.AccountsPackage SET GoodsCount=GoodsCount+@PresentPropNum WHERE UserID=@UserID AND GoodsID=@PresentPropID
	END

	-- д����ʯ��ˮ��¼
	INSERT INTO WHQJRecordDB.dbo.RecordDiamondSerial(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate) 
	VALUES(dbo.WF_GetSerialNumber(),0,@UserID,2,@CurrentDiamond,@PresentDiamond,@strClientIP,@DateTime)

END
GO


