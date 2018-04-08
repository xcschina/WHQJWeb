----------------------------------------------------------------------
-- ��Ȩ��2017
-- ʱ�䣺2017-06-8
-- ��;�����߶���
----------------------------------------------------------------------

USE [WHQJTreasureDB]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_CreateOnLineOrder') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_CreateOnLineOrder
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------------
-- ���붩��
CREATE PROCEDURE NET_PW_CreateOnLineOrder
	@dwUserID			INT,						-- �����û�
	@dwShareID			INT,						-- ��������
	@dwConfigID			INT,						-- ��ֵ��ʶ
	@strOrderID			NVARCHAR(32),				-- ������ʶ
	@strDevice			NVARCHAR(32),				-- ��Ʒ����
	@strIPAddress		NVARCHAR(15),				-- ֧����ַ
	@strErrorDescribe	NVARCHAR(127) OUTPUT		-- �����Ϣ
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

-- ������Ϣ
DECLARE @ConfigID INT
DECLARE @BindSpread INT
DECLARE @PayChannel INT

-- ������Ϣ
DECLARE @OrderID NVARCHAR(32)
DECLARE @Amount DECIMAL(18,2)
DECLARE @Diamond INT
DECLARE @PresentDiamond INT
DECLARE @OtherPresent INT
DECLARE @PayIdentity TINYINT
DECLARE @PayType TINYINT
DECLARE @CurrentTime DATETIME
DECLARE @STime NVARCHAR(10)
DECLARE @StartTime NVARCHAR(20)
DECLARE @EndTime NVARCHAR(20)

-- ִ���߼�
BEGIN
	-- ��ֵ������֤
	SELECT @PayChannel=StatusValue FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.SystemStatusInfo WITH(NOLOCK) WHERE StatusName = N'JJPayChannel'
	IF @PayChannel IS NULL OR @PayChannel=0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ����δ���ţ�'
		RETURN 2003
	END
	IF @PayChannel=1 AND @dwShareID>=200
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ����δ���ţ�'
		RETURN 2003
	END
	IF @PayChannel=2 AND @dwShareID<200 AND @dwShareID>=300
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ����δ���ţ�'
		RETURN 2003
	END
  IF @PayChannel=4 AND @dwShareID<300
  BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ����δ���ţ�'
		RETURN 2003
	END

	-- ��ֵ������֤
	SELECT @Amount=PayPrice,@Diamond=Diamond,@PresentDiamond=PresentDiamond,@PayIdentity=PayIdentity,@PayType=PayType FROM AppPayConfig WHERE ConfigID = @dwConfigID
	IF @Amount IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ��Ʒ�����ڣ�'
		RETURN 2004
	END
	IF @Amount <= 0 OR @Diamond <=0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ��Ʒ�����쳣��'
		RETURN 2004
	END

	--ʱ�����
	SELECT @CurrentTime = GETDATE()
	SET @STime = Convert(CHAR(10),@CurrentTime,120)
	SET @StartTime = @STime + N' 00:00:00'
	SET @EndTime = @STime + N' 23:59:59'

	-- ��ͨʱ����Ϊ0
	SET @OtherPresent = 0
	-- �������������ʯ(�׳�ʱ����)
	IF @PayIdentity = 2
	BEGIN
		-- ÿ���׳��ö���
		IF NOT EXISTS(SELECT OnLineID FROM OnLinePayOrder WHERE UserID=@UserID AND OrderStatus=1 AND OrderDate BETWEEN @StartTime AND @EndTime)
		BEGIN
			SET @OtherPresent = @PresentDiamond
		END
	END

	IF @PayIdentity = 3
	BEGIN
		-- �˻��׳��ö���
		IF NOT EXISTS(SELECT OnLineID FROM OnLinePayOrder WHERE UserID=@UserID AND OrderStatus=1)
		BEGIN
			SET @OtherPresent = @PresentDiamond
		END
	END

	-- �����ظ���֤
	SELECT @OrderID=OrderID FROM OnLinePayOrder WITH(NOLOCK) WHERE OrderID = @strOrderID
	IF @OrderID IS NOT NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ��æ,���Ժ����³�ֵ��'
		RETURN 2005
	END

	-- ��ȡ�û���Ϣ
	SELECT @UserID=UserID,@SpreaderID=SpreaderID,@Accounts=Accounts,@NickName=NickName,@Nullity=Nullity,@GameID=GameID FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID = @dwUserID
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ�˺Ų����ڣ�'
		RETURN 2006
	END
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ�˺��Ѷ���״̬��'
		RETURN 2007
	END

	-- ��ֵ�ƹ���֤
  IF @strDevice = ''
  BEGIN
    SELECT @BindSpread=StatusValue FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.SystemStatusInfo WITH(NOLOCK) WHERE StatusName = N'JJPayBindSpread'
    IF @SpreaderID<=0 AND @BindSpread=0
    BEGIN
      SET @strErrorDescribe=N'��Ǹ����ֵ�˺�δ���ƹ��ˣ�'
      RETURN 2008
    END
  END

	-- �׳���֤
	-- IF @PayIdentity=2
	-- BEGIN
	-- 	IF EXISTS(SELECT OnLineID FROM OnLinePayOrder WHERE UserID=@UserID AND OrderStatus=1 AND OrderDate BETWEEN @StartTime AND @EndTime)
	-- 	BEGIN
	-- 		SET @strErrorDescribe=N'��Ǹ���׳�ÿ����޳�ֵһ�Σ�'
	-- 		RETURN 2004
	-- 	END
	-- END

	-- д�붩����Ϣ
	INSERT INTO OnLinePayOrder(ConfigID,ShareID,UserID,GameID,Accounts,NickName,OrderID,OrderType,Amount,Diamond,OtherPresent,OrderStatus,OrderDate,OrderAddress)
	VALUES(@dwConfigID,@dwShareID,@UserID,@GameID,@Accounts,@NickName,@strOrderID,@PayType,@Amount,@Diamond,@OtherPresent,0,@CurrentTime,@strIPAddress)

	-- ����������
	SELECT @dwConfigID AS ConfigID,@dwShareID AS ShareID,@UserID AS UserID,@GameID AS GameID,@Accounts AS Accounts,@NickName AS NickName,@strOrderID AS OrderID,@PayType AS OrderType,
	@Amount AS Amount,@Diamond AS Diamond,@OtherPresent AS OtherPresent,0 AS OrderStatus,@CurrentTime AS OrderDate,@strIPAddress AS OrderAddress

END
RETURN 0
GO



