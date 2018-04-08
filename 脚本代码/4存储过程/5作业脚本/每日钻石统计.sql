----------------------------------------------------------------------
-- �汾��2013
-- ʱ�䣺2013-04-22
-- ��;��ÿ������ͳ����ʯ����
----------------------------------------------------------------------
USE [WHQJTreasureDB]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PJ_DiamondStatistics]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PJ_DiamondStatistics]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PJ_DiamondStatistics]
			
WITH ENCRYPTION AS

-- ��������
DECLARE @DateID INT
DECLARE @TodayTime DATETIME

DECLARE @SysPresentDiamond BIGINT
DECLARE @AAGameDiamond BIGINT
DECLARE @AdminPresentDiamond BIGINT
DECLARE @PayDiamond BIGINT

DECLARE @FirstDiamond BIGINT
DECLARE @SecondDiamond BIGINT
DECLARE @ThirdDiamond BIGINT
DECLARE @TotalDiamond BIGINT
DECLARE @RoomCostDiamond BIGINT
DECLARE @PropCostDiamond BIGINT

DECLARE @STime NVARCHAR(10)
DECLARE @StartTime NVARCHAR(20)
DECLARE @EndTime NVARCHAR(20)

-- ִ���߼�
BEGIN
	SET @TodayTime = DATEADD(DAY,-1,GETDATE())
	SET @STime = Convert(CHAR(10),@TodayTime,120)
	SET @StartTime = @STime + N' 00:00:00'
	SET @EndTime = @STime + N' 23:59:59'

	-- һ������ӵ����ʯ����
	SELECT @FirstDiamond=ISNULL(SUM(Diamond),0) FROM UserCurrency WHERE UserID IN(SELECT UserID FROM WHQJAccountsDB.dbo.AccountsAgentInfo WHERE AgentLevel = 1)

	-- ��������ӵ����ʯ����
	SELECT @SecondDiamond=ISNULL(SUM(Diamond),0) FROM UserCurrency WHERE UserID IN(SELECT UserID FROM WHQJAccountsDB.dbo.AccountsAgentInfo WHERE AgentLevel = 2)

	-- ��������ӵ����ʯ����
	SELECT @ThirdDiamond=ISNULL(SUM(Diamond),0) FROM UserCurrency WHERE UserID IN(SELECT UserID FROM WHQJAccountsDB.dbo.AccountsAgentInfo WHERE AgentLevel = 3)

	-- ƽ̨��ʯ����
	SELECT @TotalDiamond=ISNULL(SUM(Diamond),0) FROM UserCurrency

	-- ��ֵ��ʯ����
	SELECT @PayDiamond=ISNULL(SUM(Diamond+OtherPresent),0) FROM OnLinePayOrder WITH(NOLOCK) WHERE OrderStatus = 1 AND PayDate BETWEEN @StartTime AND @EndTime

	-- ϵͳ����Ա������ʯ����
	SELECT @AdminPresentDiamond=ISNULL(SUM(AddDiamond),0) FROM WHQJRecordDB.dbo.RecordGrantDiamond WITH(NOLOCK) WHERE TypeID = 0 AND CollectDate BETWEEN @StartTime AND @EndTime

	-- ϵͳ����������ʯ����
	SELECT @SysPresentDiamond=ISNULL(SUM(ChangeDiamond),0) FROM WHQJRecordDB.dbo.RecordDiamondSerial WITH(NOLOCK) WHERE TypeID IN(1,2,4,5,6) AND CollectDate BETWEEN @StartTime AND @EndTime

	-- ����������������
	SELECT @RoomCostDiamond=ISNULL(SUM(CreateTableFee),0) FROM WHQJPlatformDB.dbo.StreamCreateTableFeeInfo WITH(NOLOCK) WHERE CreateDate BETWEEN @StartTime AND @EndTime

	-- AA ����Ϸ������ʯ
	SELECT @AAGameDiamond=ISNULL(SUM(Diamond),0) FROM WHQJRecordDB.dbo.RecordGameDiamond WITH(NOLOCK) WHERE CollectDate BETWEEN @StartTime AND @EndTime

	-- ���������������
	SELECT @PropCostDiamond=ISNULL(SUM(Diamond),0) FROM WHQJRecordDB.dbo.RecordBuyNewProperty WITH(NOLOCK) WHERE CollectDate BETWEEN @StartTime AND @EndTime

	-- д��ͳ�Ʊ�
	SET @DateID = CAST(CAST(@TodayTime AS FLOAT) AS INT)
	DELETE WHQJRecordDBLink.WHQJRecordDB.dbo.RecordEveryDayCurrency WHERE DateID = @DateID
	INSERT INTO WHQJRecordDBLink.WHQJRecordDB.dbo.RecordEveryDayCurrency 
	VALUES(@DateID,@FirstDiamond,@SecondDiamond,@ThirdDiamond,@TotalDiamond,@SysPresentDiamond,@AdminPresentDiamond,@PayDiamond,@RoomCostDiamond,@PropCostDiamond,@AAGameDiamond,@TodayTime)

END
GO
