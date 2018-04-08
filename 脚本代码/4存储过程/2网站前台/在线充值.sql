----------------------------------------------------------------------
-- ��Ȩ��2017
-- ʱ�䣺2017-06-8
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
	@strOrdersID		NVARCHAR(50),
	--	�������
	@PayAmount			DECIMAL(18,2),
	--  ֧�����
	@strIPAddress		NVARCHAR(31),
	--	�û��ʺ�
	@strErrorDescribe	NVARCHAR(127) OUTPUT
--	�����Ϣ
WITH
	ENCRYPTION
AS

-- ��������
SET NOCOUNT ON

-- ������Ϣ
DECLARE @UserID INT
DECLARE @Amount DECIMAL(18,2)
DECLARE @Diamond INT
DECLARE @PresentDiamond INT
DECLARE @OtherPresent INT
DECLARE @BeforeDiamond BIGINT
DECLARE @OrderStatus TINYINT
DECLARE @PayIdentity TINYINT
DECLARE @DateTime DATETIME
DECLARE @CurrentTime DATETIME
DECLARE @STime NVARCHAR(10)
DECLARE @StartTime NVARCHAR(20)
DECLARE @EndTime NVARCHAR(20)

-- ִ���߼�
BEGIN
	SET @DateTime = GETDATE()
	-- ������ѯ
	SELECT @UserID=UserID, @Amount=Amount, @Diamond=Diamond, @OtherPresent=OtherPresent, @OrderStatus=OrderStatus
	FROM OnLinePayOrder WITH(NOLOCK)
	WHERE OrderID = @strOrdersID
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ����������!'
		RETURN 1001
	END
	IF @OrderStatus=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ���������!'
		RETURN 1002
	END
	IF @Amount != @PayAmount
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��֧��������!'
		RETURN 1003
	END

	--ʱ�����
	SELECT @CurrentTime = GETDATE()
	SET @STime = Convert(CHAR(10),@CurrentTime,120)
	SET @StartTime = @STime + N' 00:00:00'
	SET @EndTime = @STime + N' 23:59:59'
	-- �Զ��������ֶν�����������
	IF @PayIdentity=2	-- ÿ���׳�
	BEGIN
		IF EXISTS(SELECT OnLineID
		FROM OnLinePayOrder
		WHERE UserID=@UserID AND OrderStatus=1 AND OrderDate BETWEEN @StartTime AND @EndTime)
		BEGIN
			SET @OtherPresent = 0
		END
	END
	ELSE IF @PayIdentity=3 --Ԥ���� �˻��׳�ģʽ
	BEGIN
		IF EXISTS(SELECT OnLineID
		FROM OnLinePayOrder
		WHERE UserID=@UserID AND OrderStatus=1)
		BEGIN
			SET @OtherPresent = 0
		END
	END
	ELSE
	BEGIN
		--�������һ�ɹ���
		SET @OtherPresent = 0
	END

	SET @PresentDiamond = @Diamond + @OtherPresent

	-- ������
	BEGIN TRAN

	SELECT @BeforeDiamond=Diamond
	FROM UserCurrency WITH(ROWLOCK)
	WHERE UserID=@UserID
	IF @BeforeDiamond IS NULL
	BEGIN
		SET @BeforeDiamond=0
		INSERT INTO UserCurrency
		VALUES(@UserID, @PresentDiamond)
	END
	ELSE
	BEGIN
		UPDATE UserCurrency SET Diamond = Diamond + @PresentDiamond WHERE UserID=@UserID
	END
	IF @@ROWCOUNT <=0
	BEGIN
		ROLLBACK TRAN
		SET @strErrorDescribe=N'��Ǹ�������쳣�����Ժ�����!'
		RETURN 2001
	END
	UPDATE OnLinePayOrder SET OrderStatus=1,OtherPresent=@OtherPresent,BeforeDiamond=@BeforeDiamond,PayDate=@CurrentTime,PayAddress=@strIPAddress WHERE OrderID = @strOrdersID
	IF @@ROWCOUNT <=0
	BEGIN
		ROLLBACK TRAN
		SET @strErrorDescribe=N'��Ǹ�������쳣�����Ժ�����!'
		RETURN 2001
	END

	-- д����ʯ��ˮ��¼
	INSERT INTO WHQJRecordDB.dbo.RecordDiamondSerial
		(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate)
	VALUES(dbo.WF_GetSerialNumber(), 0, @UserID, 3, @BeforeDiamond, @PresentDiamond, @strIPAddress, @DateTime)

	-- ������ڷ������ã�д�뷵����¼
	IF EXISTS (SELECT 1 FROM SpreadReturnConfig WHERE Nullity=0)
	BEGIN
		DECLARE @ReturnType TINYINT
		SELECT @ReturnType = StatusValue FROM WHQJAccountsDB.DBO.SystemStatusInfo WHERE StatusName = N'SpreadReturnType'
		IF @ReturnType IS NULL
		BEGIN
			SET @ReturnType = 0
		END
		INSERT WHQJRecordDB.DBO.RecordSpreadReturn (SourceUserID,TargetUserID,SourceDiamond,Spreadlevel,ReturnScale,ReturnNum,ReturnType,CollectDate)
		SELECT @UserID,A.UserID,@Diamond,B.SpreadLevel,B.PresentScale,@Diamond*B.PresentScale,@ReturnType,@DateTime FROM (SELECT UserID,LevelID FROM [dbo].[WF_GetAgentAboveAccounts](@UserID) ) AS A,SpreadReturnConfig AS B WHERE B.SpreadLevel=A.LevelID-1 AND A.LevelID>1 AND A.LevelID<=4 AND B.Nullity=0
	END

	COMMIT TRAN

END
RETURN 0
GO
