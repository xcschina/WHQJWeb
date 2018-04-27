----------------------------------------------------------------------
-- ��Ȩ��2017
-- ʱ�䣺2018-04-27
-- ��;�����߳�ֵ
----------------------------------------------------------------------

USE [WHQJTreasureDB]
GO

-- ���߳�ֵ
IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PW_FinishOnLineOrder') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_FinishOnLineOrder
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---------------------------------------------------------------------------------------
-- ���߳�ֵ
CREATE PROCEDURE NET_PW_FinishOnLineOrder
	@strOrdersID		NVARCHAR(32),
	--	�������
	@PayAmount			DECIMAL(18,2),
	--	�û��ʺ�
	@strErrorDescribe	NVARCHAR(127) OUTPUT
--	�����Ϣ
WITH
	ENCRYPTION
AS

-- ��������
SET NOCOUNT ON

-- ������Ϣ
DECLARE @ConfigID INT
DECLARE @UserID INT
DECLARE @Nullity TINYINT
DECLARE @Amount DECIMAL(18,2)
DECLARE @ScoreType TINYINT
DECLARE @Score INT
DECLARE @PresentScore INT
DECLARE @OtherPresent INT
DECLARE @BeforeScore BIGINT
DECLARE @OrderStatus TINYINT
DECLARE @PayIdentity TINYINT
DECLARE @DateTime DATETIME
DECLARE @CurrentTime DATETIME
DECLARE @OrderAddress NVARCHAR(15)
DECLARE @STime NVARCHAR(10)
DECLARE @StartTime NVARCHAR(20)
DECLARE @EndTime NVARCHAR(20)

-- ִ���߼�
BEGIN
	SET @DateTime = GETDATE()
	-- ������ѯ
	SELECT @ConfigID=ConfigID,@UserID=UserID, @Amount=Amount,@ScoreType=ScoreType, @Score=Score,@OrderAddress=OrderAddress, @OtherPresent=OtherPresent, @OrderStatus=OrderStatus
	FROM OnLinePayOrder WITH(NOLOCK)
	WHERE OrderID = @strOrdersID
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ����������!'
		RETURN 1001
	END
	IF @OrderStatus=2
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ���������!'
		RETURN 1002
	END
	IF @Amount != @PayAmount
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��֧��������!'
		RETURN 1003
	END

		-- ��ȡ�û���Ϣ
	SELECT @Nullity=Nullity FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE UserID = @UserID
	IF @Nullity IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ�˺Ų����ڣ�'
		RETURN 1004
	END
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ�˺��Ѷ���״̬��'
		RETURN 1005
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

	-- ������� ����������˽��д��Ҵ���
	INSERT INTO MiddleMoney (RecordID,UserID,MiddleMoney,MoneyType) VALUES (@strOrdersID,@UserID,@Amount,@ScoreType)

	UPDATE OnLinePayOrder SET OrderStatus = 1,BeforeScore = @BeforeScore WHERE OrderID = @strOrdersID AND UserID = @UserID

END
RETURN 0
GO
