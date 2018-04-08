----------------------------------------------------------------------
-- ʱ�䣺2010-03-16
-- ��;�����ͽ��
----------------------------------------------------------------------

USE WHQJTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[WSP_PM_GrantTreasure]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[WSP_PM_GrantTreasure]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO
----------------------------------------------------------------------

CREATE PROCEDURE WSP_PM_GrantTreasure
	@MasterID INT,				-- ����Ա��ʶ
	@ClientIP VARCHAR(15),		-- ���͵�ַ
	@UserID INT,				-- �û���ʶ
	@AddGold BIGINT,			-- ���ͽ��
	@Reason NVARCHAR(32)		-- ���ͱ�ע	
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �û������Ϣ
DECLARE @CurScore BIGINT
DECLARE @CurInsureScore BIGINT
DECLARE @Nullity TINYINT
DECLARE @DateTime DATETIME
DECLARE @RegisterIP NVARCHAR(15)
DECLARE @RegisterDate DATETIME
DECLARE @RegisterMachine NVARCHAR(32)
DECLARE @InsureScore BIGINT

-- ִ���߼�
BEGIN
	-- �û���֤
	SELECT @Nullity=Nullity,@RegisterIP=RegisterIP,@RegisterDate=RegisterDate,@RegisterMachine=RegisterMachine FROM WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID = @UserID
	IF @Nullity IS NULL
	BEGIN
		RETURN 1001
	END
	IF @Nullity = 1
	BEGIN
		RETURN 1001
	END

	-- ��ȡ�û���ʯ
	SELECT @CurScore=Score,@CurInsureScore=InsureScore FROM GameScoreInfo WHERE UserID = @UserID
	IF @CurInsureScore IS NULL
	BEGIN
		SET @CurInsureScore = 0
		IF @AddGold<0 SET @InsureScore=0 ELSE SET @InsureScore = @AddGold
		INSERT INTO GameScoreInfo(UserID,Score,InsureScore,RegisterIP,RegisterDate,RegisterMachine) VALUES(@UserID,0,@InsureScore,@RegisterIP,@RegisterDate,@RegisterMachine)
	END
	ELSE
	BEGIN
		SET @InsureScore = @CurInsureScore + @AddGold
		IF @InsureScore<0 SET @InsureScore=0
		UPDATE GameScoreInfo SET InsureScore = @InsureScore WHERE UserID=@UserID
	END
	-- д�����ͼ�¼
	SET @DateTime = GETDATE()
	INSERT INTO WHQJRecordDB.dbo.RecordGrantTreasure(MasterID,ClientIP,CollectDate,UserID,CurGold,AddGold,Reason) VALUES(@MasterID,@ClientIP,@DateTime,@UserID,@CurInsureScore,@AddGold,@Reason)
	-- д����ˮ��¼
	INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial(SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate) 
	VALUES(dbo.WF_GetSerialNumber(),@MasterID,@UserID,0,@CurScore,@CurInsureScore,@AddGold,@ClientIP,@DateTime)

END
RETURN 0

