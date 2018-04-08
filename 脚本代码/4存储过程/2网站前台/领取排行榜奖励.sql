----------------------------------------------------------------------
-- �汾��2013
-- ʱ�䣺2013-04-22
-- ��;����ȡ���а���
----------------------------------------------------------------------
USE [WHQJNativeWebDB]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PJ_RecevieRankingAward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PJ_RecevieRankingAward]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PJ_RecevieRankingAward]
	@dwUserID INT,
	@dwDateID INT,
	@dwTypeID INT,
	@strClientIP NVARCHAR(15),
	@strErrorDescribe NVARCHAR(127) OUTPUT	-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
DECLARE @Nullity INT
DECLARE @Diamond INT
DECLARE @BeforeDiamond BIGINT
DECLARE @ValidityTime DATETIME
DECLARE @ReceiveState BIT
DECLARE @DateTimeNow DATETIME

-- ִ���߼�
BEGIN
	-- ��ȡ�û���Ϣ
	SELECT @Nullity=Nullity FROM WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID=@dwUserID
	IF @Nullity IS NULL
	BEGIN
		SET @strErrorDescribe =N'��Ǹ,��ȡ�û�������'
		RETURN 1001
	END
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe =N'��Ǹ,��ȡ�û��Ѷ���'
		RETURN 1002
	END
	
	-- ��ȡ�û���ʯ��Ϣ
	SELECT @BeforeDiamond=Diamond FROM WHQJTreasureDB.dbo.UserCurrency WHERE UserID=@dwUserID
	IF @BeforeDiamond IS NULL
	BEGIN
		SET @BeforeDiamond = 0
		INSERT INTO WHQJTreasureDB.dbo.UserCurrency VALUES(@dwUserID,0)
	END

	SET @DateTimeNow = GETDATE()

	-- ��ȡ���а�����Ϣ
	SELECT @Diamond=Diamond,@ValidityTime=ValidityTime,@ReceiveState=ReceiveState FROM RecordRankingRecevie WITH(NOLOCK) WHERE DateID=@dwDateID AND UserID=@dwUserID AND TypeID=@dwTypeID
	IF @Diamond IS NULL
	BEGIN
		SET @strErrorDescribe =N'��Ǹ,���������а���'
		RETURN 1003
	END
	IF @ReceiveState=1
	BEGIN
		SET @strErrorDescribe =N'��Ǹ,���а��������ظ���ȡ'
		RETURN 1003
	END
	IF @ValidityTime< @DateTimeNow
	BEGIN
		SET @strErrorDescribe =N'��Ǹ,���а����ѹ���'
		RETURN 1003
	END

	-- �޸���ȡ״̬
	UPDATE RecordRankingRecevie SET ReceiveState=1,BeforeDiamond=@BeforeDiamond,ReceiveIP=@strClientIP,ReceiveTime=@DateTimeNow WHERE DateID=@dwDateID AND UserID=@dwUserID AND TypeID=@dwTypeID
	IF @@ROWCOUNT <= 0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ,���а�����ȡʧ�ܣ�'
		RETURN 6
	END

	-- �޸���ȡ����ʯ��Ϣ
	UPDATE WHQJTreasureDB.dbo.UserCurrency SET Diamond=Diamond+@Diamond WHERE UserID=@dwUserID

	-- д����ʯ��ˮ��¼
	INSERT INTO WHQJRecordDB.dbo.RecordDiamondSerial(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate) 
	VALUES(dbo.WF_GetSerialNumber(),0,@dwUserID,5,@BeforeDiamond,@Diamond,@strClientIP,@DateTimeNow)

	-- �����ȡ����ʯ��
	SELECT @dwUserID AS UserID,(@BeforeDiamond+@Diamond) AS Diamond
	SET @strErrorDescribe= N'��ϲ�����'+ CAST(@Diamond AS NVARCHAR(30)) +'��ʯ���н���'

END
RETURN 0
GO
