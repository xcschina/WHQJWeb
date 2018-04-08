----------------------------------------------------------------------
-- �汾��2013
-- ʱ�䣺2013-04-22
-- ��;����ȡע�����ͽ���
----------------------------------------------------------------------
USE [WHQJTreasureDB]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PJ_RecevieRegisterGrant]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PJ_RecevieRegisterGrant]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PJ_RecevieRegisterGrant]
	@dwUserID INT,
	@strClientIP NVARCHAR(15),
	@strErrorDescribe NVARCHAR(127) OUTPUT	-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
DECLARE @Nullity INT
DECLARE @Diamond INT
DECLARE @GrantDiamond INT
DECLARE @GrantGold INT
DECLARE @BeforeDiamond BIGINT
DECLARE @BeforeGold BIGINT
DECLARE @BeforeInsureScore BIGINT
DECLARE @ValidityTime DATETIME
DECLARE @ReceiveState BIT
DECLARE @DateTimeNow DATETIME
DECLARE @RegisterIP NVARCHAR(15)
DECLARE @RegisterDate DATETIME
DECLARE @RegisterMachine NVARCHAR(32)
DECLARE @Descript NVARCHAR(5)

-- ִ���߼�
BEGIN
	-- ��ȡ�û���Ϣ
	SELECT @Nullity=Nullity,@RegisterIP=RegisterIP,@RegisterDate=RegisterDate,@RegisterMachine=RegisterMachine FROM WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID=@dwUserID
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
	
	-- ��ȡע���¼
	SELECT @GrantDiamond=GrantDiamond,@GrantGold=GrantGold,@ReceiveState=IsReceive FROM WHQJRecordDB.dbo.RecordRegisterGrant WITH(NOLOCK) WHERE UserID = @dwUserID
	IF @ReceiveState IS NULL
	BEGIN
		SET @strErrorDescribe =N'��Ǹ,��ȡ�û�������'
		RETURN 2001
	END
	IF @ReceiveState=1
	BEGIN
		SET @strErrorDescribe =N'��Ǹ,ע�ά������ȡ'
		RETURN 2002
	END
	IF @GrantDiamond<=0 AND @GrantGold<=0
	BEGIN
		SET @strErrorDescribe =N'��Ǹ,ע�ά���쳣'
		RETURN 2003
	END

	SET @strErrorDescribe= N'��ϲ�����'

	-- ע�ά��Ϊ��ʯ
	IF @GrantDiamond>0 SET @Descript='��' ELSE SET @Descript=''
	IF @GrantDiamond>0
	BEGIN
		SET @strErrorDescribe = @strErrorDescribe + CAST(@GrantDiamond AS NVARCHAR(30)) + '��ʯ'
		-- �����û���ʯ��Ϣ
		SELECT @BeforeDiamond=Diamond FROM UserCurrency WHERE UserID=@dwUserID
		IF @BeforeDiamond IS NULL
		BEGIN
			SET @BeforeDiamond = 0
			INSERT INTO UserCurrency VALUES(@dwUserID,@GrantDiamond)
		END
		ELSE 
		BEGIN
			UPDATE UserCurrency SET Diamond=Diamond + @GrantDiamond WHERE UserID=@dwUserID
		END
	END

	-- ע�ά��Ϊ���
	IF @GrantGold>0
	BEGIN
		SET @strErrorDescribe = @strErrorDescribe + @Descript + CAST(@GrantGold AS NVARCHAR(30)) + '���'
		-- �����û������Ϣ
		SELECT @BeforeGold=Score,@BeforeInsureScore=InsureScore FROM GameScoreInfo WHERE UserID = @dwUserID
		IF @BeforeGold IS NULL
		BEGIN
			SET @BeforeGold = 0
			SET @BeforeInsureScore = 0
			INSERT INTO GameScoreInfo(UserID,Score,RegisterIP,RegisterDate,RegisterMachine) VALUES(@dwUserID,@GrantGold,@RegisterIP,@RegisterDate,@RegisterMachine)
		END
		ELSE
		BEGIN
			UPDATE GameScoreInfo SET Score = Score + @GrantGold WHERE UserID=@dwUserID
		END
	END
	SET @strErrorDescribe = @strErrorDescribe + 'ע�ά��'

	-- ����ע���¼
	SET @DateTimeNow = GETDATE()
	UPDATE WHQJRecordDB.dbo.RecordRegisterGrant SET IsReceive=1,ReceiveDate=@DateTimeNow,ReceiveIP=@strClientIP WHERE UserID=@dwUserID
	IF @@ROWCOUNT>0
	BEGIN
		 -- д����ˮ��¼
		 IF @GrantDiamond>0
		 BEGIN
			INSERT INTO WHQJRecordDBLink.WHQJRecordDB.dbo.RecordDiamondSerial(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate) 
			VALUES(dbo.WF_GetSerialNumber(),0,@dwUserID,1,@BeforeDiamond,@GrantDiamond,@strClientIP,@DateTimeNow)
		 END
		 IF @GrantGold>0
		 BEGIN
			INSERT INTO WHQJRecordDBLink.WHQJRecordDB.dbo.RecordTreasureSerial(SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate) 
			VALUES(dbo.WF_GetSerialNumber(),0,@dwUserID,1,@BeforeGold,@BeforeInsureScore,@GrantGold,@strClientIP,@DateTimeNow)
		 END
	END

	-- �����ȡ����ʯ���ͽ����
	SELECT (@BeforeGold+@GrantGold) AS Score,@BeforeInsureScore AS InsureScore,(@BeforeDiamond+@GrantDiamond) AS Diamond
END
RETURN 0
GO
