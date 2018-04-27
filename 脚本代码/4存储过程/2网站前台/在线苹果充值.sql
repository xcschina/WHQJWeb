----------------------------------------------------------------------
-- ��Ȩ��2017
-- ʱ�䣺2018-04-27
-- ��;��ƻ����ֵ
----------------------------------------------------------------------

USE [WHQJTreasureDB]
GO

-- ���߳�ֵ
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_FinishOnLineOrderIOS') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_FinishOnLineOrderIOS
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---------------------------------------------------------------------------------------
-- ���߳�ֵ
CREATE PROCEDURE NET_PW_FinishOnLineOrderIOS
	@strOrdersID		NVARCHAR(32),			--	�������
	@PayAmount			DECIMAL(18,2),			--  ֧�����
	@dwUserID			INT,					--	��ֵ�û�
	@strAppleID			NVARCHAR(32),			--  ��Ʒ��ʶ
	@strIPAddress		NVARCHAR(31),			--	�û��ʺ�
	@strErrorDescribe	NVARCHAR(127) OUTPUT	--	�����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �ʺ�����
DECLARE @Accounts NVARCHAR(31)
DECLARE @NickName NVARCHAR(31)
DECLARE @UserID INT
DECLARE @GameID INT
DECLARE @SpreaderID INT
DECLARE @Nullity TINYINT
DECLARE @BindSpread INT

-- ������Ϣ
DECLARE @ConfigID INT
DECLARE @Amount DECIMAL(18,2)
DECLARE @ScoreType TINYINT
DECLARE @Score INT
DECLARE @FristPresent INT
DECLARE @PresentScore INT
DECLARE @OtherPresent INT
DECLARE @BeforeScore BIGINT
DECLARE @OrderStatus TINYINT
DECLARE @DateTime DATETIME

-- ִ���߼�
BEGIN
	SET @DateTime = GETDATE()

	-- ��ȡ�û���Ϣ
	SELECT @UserID=UserID,@GameID=GameID,@SpreaderID=SpreaderID,@Accounts=Accounts,@NickName=NickName,@Nullity=Nullity FROM WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID = @dwUserID
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ�˺Ų����ڣ�'
		RETURN 1001
	END
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ�˺��Ѷ���״̬��'
		RETURN 1002
	END

	-- ��ֵ�ƹ���֤
	SELECT @BindSpread=StatusValue FROM WHQJAccountsDB.dbo.SystemStatusInfo WITH(NOLOCK) WHERE StatusName = N'JJPayBindSpread'
	IF @SpreaderID<=0 AND @BindSpread=0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ�˺�δ���ƹ��ˣ�'
		RETURN 1003
	END

	-- ���ò�ѯ
	SELECT @ConfigID=ConfigID,@Amount=PayPrice,@ScoreType = ScoreType,@Score=Score,@PresentScore=PresentScore,@FristPresent = FristPresent FROM AppPayConfig WITH(NOLOCK) WHERE PayType=1 AND AppleID=@strAppleID
	IF @ConfigID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ��Ʒ������!'
		RETURN 2001
	END
	IF @Amount <= 0 OR @Score <=0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ��Ʒ�����쳣��'
		RETURN 2002
	END
	IF @Amount!=@PayAmount
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��֧��������!'
		RETURN 2003
	END

	-- ������ѯ
	IF EXISTS(SELECT OnLineID FROM OnLinePayOrder WITH(NOLOCK) WHERE OrderID = @strOrdersID)
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ���������!'
		RETURN 2004
	END

	SET @OtherPresent = @FristPresent
	-- �˻��������׳�
	IF EXISTS(SELECT 1 FROM OnLinePayOrder WHERE UserID=@UserID AND ConfigID=@ConfigID AND OrderStatus>1)
	BEGIN
		SET @OtherPresent = @PresentScore
	END

	IF @ScoreType = 0 
	BEGIN
		SELECT @BeforeScore = Score FROM WHQJTreasureDB.DBO.GameScoreInfo(NOLOCK) WHERE UserID = @UserID
		IF @BeforeScore IS NULL 
		BEGIN
			INSERT WHQJTreasureDB.DBO.GameScoreInfo (UserID,Score) VALUES (@UserID,0)
			SET @BeforeScore = 0
		END
	END	
	ELSE IF @ScoreType = 1
	BEGIN
		SELECT @BeforeScore = Diamond FROM WHQJTreasureDB.DBO.UserCurrency(NOLOCK) WHERE UserID = @UserID
		IF @BeforeScore IS NULL 
		BEGIN
			INSERT WHQJTreasureDB.DBO.UserCurrency (UserID,Diamond) VALUES (@UserID,0)
			SET @BeforeScore = 0
		END
	END
	
	-- ��¼����
	INSERT INTO OnLinePayOrder(ConfigID,ShareID,UserID,GameID,Accounts,NickName,OrderID,OrderType,Amount,ScoreType,Score,OtherPresent,OrderStatus,OrderDate,OrderAddress,BeforeScore)
	VALUES(@ConfigID,800,@UserID,@GameID,@Accounts,@NickName,@strOrdersID,1,@Amount,@ScoreType,@Score,@OtherPresent,1,@DateTime,@strIPAddress,@BeforeScore)

	-- ������� ����������˽��д��Ҵ���
	INSERT INTO MiddleMoney (RecordID,UserID,MiddleMoney,MoneyType) VALUES (@strOrdersID,@UserID,@Amount,@ScoreType)

END
RETURN 0
GO
