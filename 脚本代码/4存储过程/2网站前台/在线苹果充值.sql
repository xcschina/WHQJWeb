----------------------------------------------------------------------
-- ��Ȩ��2017
-- ʱ�䣺2017-06-8
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
	@strOrdersID		NVARCHAR(50),			--	�������
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
DECLARE @Diamond INT
DECLARE @PresentDiamond INT
DECLARE @OtherPresent INT
DECLARE @BeforeDiamond BIGINT
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
	SELECT @ConfigID=ConfigID,@Amount=PayPrice,@Diamond=Diamond,@PresentDiamond=PresentDiamond FROM AppPayConfig WITH(NOLOCK) WHERE PayType=1 AND AppleID=@strAppleID
	IF @ConfigID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ��Ʒ������!'
		RETURN 2001
	END
	IF @Amount <= 0 OR @Diamond <=0
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

	-- �������������ʯ
	SET @PresentDiamond = @PresentDiamond + @Diamond

	-- ������
	BEGIN TRAN

	SELECT @BeforeDiamond=Diamond FROM UserCurrency WITH(ROWLOCK) WHERE UserID=@UserID
	IF @BeforeDiamond IS NULL
	BEGIN
		SET @BeforeDiamond=0
		INSERT INTO UserCurrency VALUES(@UserID,@PresentDiamond)
	END
	ELSE
	BEGIN
		UPDATE UserCurrency SET Diamond = Diamond + @PresentDiamond WHERE UserID=@UserID
	END
	IF @@ROWCOUNT <=0
	BEGIN
		ROLLBACK TRAN
		SET @strErrorDescribe=N'��Ǹ�������쳣�����Ժ�����!'
		RETURN 3001
	END
	INSERT INTO OnLinePayOrder(ConfigID,ShareID,UserID,GameID,Accounts,NickName,OrderID,OrderType,Amount,Diamond,OtherPresent,OrderStatus,OrderDate,OrderAddress,BeforeDiamond,PayDate,PayAddress)
	VALUES(@ConfigID,800,@UserID,@GameID,@Accounts,@NickName,@strOrdersID,1,@Amount,@Diamond,@PresentDiamond,1,@DateTime,@strIPAddress,@BeforeDiamond,@DateTime,@strIPAddress)
	IF @@ROWCOUNT <=0
	BEGIN
		ROLLBACK TRAN
		SET @strErrorDescribe=N'��Ǹ�������쳣�����Ժ�����!'
		RETURN 3002
	END

	-- д����ʯ�仯��¼
	INSERT INTO WHQJRecordDB.dbo.RecordDiamondSerial(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate)
	VALUES(dbo.WF_GetSerialNumber(),0,@UserID,3,@BeforeDiamond,@PresentDiamond,@strIPAddress,@DateTime)

	-- ������ڷ������ã�д�뷵����¼
	IF EXISTS (SELECT 1 FROM SpreadReturnConfig WHERE Nullity=0)
	BEGIN
		DECLARE @ReturnType TINYINT
		SELECT @ReturnType = StatusValue FROM WHQJAccountsDB.DBO.SystemStatusInfo WHERE StatusName = N'SpreadReturnType'
		IF @ReturnType IS NULL
		BEGIN
			SET @ReturnType = 0
		END
		INSERT WHQJRecordDB.DBO.RecordSpreadReturn (SourceUserID,TargetUserID,SourceDiamond,SpreadlEvel,ReturnScale,ReturnNum,ReturnType,CollectDate)
		SELECT @UserID,A.UserID,@Diamond,B.SpreadLevel,B.PresentScale,@Diamond*B.PresentScale,@ReturnType,@DateTime FROM (SELECT UserID,LevelID FROM [dbo].[WF_GetAgentAboveAccounts](@UserID) ) AS A,SpreadReturnConfig AS B WHERE B.SpreadLevel=A.LevelID-1 AND A.LevelID>1 AND A.LevelID<=4 AND B.Nullity=0
	END

	COMMIT TRAN

END
RETURN 0
GO
