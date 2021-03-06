----------------------------------------------------------------------
-- 版本：2017
-- 时间：2017-10-26
-- 用途：统计每日数据，每天凌晨4点自动统计
----------------------------------------------------------------------
USE [WHQJRecordDB]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PJ_AnalEveryDayDataStat]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PJ_AnalEveryDayDataStat]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PJ_AnalEveryDayDataStat]
			
WITH ENCRYPTION AS

-- 属性设置
DECLARE @UserTotal INT					-- 用户总数
DECLARE @PayUserTotal INT				-- 充值玩家
DECLARE @ActiveUserTotal INT			-- 活跃玩家
DECLARE @LossUser INT					-- 当日流失玩家
DECLARE @LossUserTotal INT				-- 玩家流失总数
DECLARE @LossPayUser INT				-- 当日充值玩家流失
DECLARE @LossPayUserTotal INT			-- 充值玩家流失总数
DECLARE @PayAmountTotal BIGINT			-- 充值RMB总数
DECLARE @PayAmountForCurrency BIGINT	-- 充值平台币RMB总数
DECLARE @CurrencyTotal BIGINT			-- 平台币总数
DECLARE @GoldTotal BIGINT				-- 金币总数
DECLARE @UserAVGOnlineTime BIGINT		-- 平均时长
DECLARE @GameTax BIGINT					-- 当日游戏税收
DECLARE @GameTaxTotal BIGINT			-- 游戏总税收
DECLARE @BankTax BIGINT					-- 当日银行税收
DECLARE @Waste BIGINT					-- 当日游戏损耗

DECLARE @DateID INT						-- 统计日期ID
DECLARE @StatsStartTime DATETIME		-- 统计日开始时间
DECLARE @StatsEndTime DATETIME			-- 统计日结束时间

-- 执行逻辑
BEGIN
	SET @StatsEndTime=CONVERT(VARCHAR(10),GETDATE(),23)
	SET @StatsStartTime=CONVERT(VARCHAR(10),GETDATE()-1,23) 
	SET @DateID=CAST(CAST(GETDATE()-1 AS FLOAT) AS INT)
	
	-- 用户总数
	SELECT @UserTotal=COUNT(UserID) FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo 
	WHERE IsAndroid=0 AND RegisterDate<@StatsEndTime
	
	-- 充值玩家总数
	SELECT @PayUserTotal=COUNT(UserID) FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo 
	WHERE UserID IN (SELECT UserID FROM WHQJTreasureDBLink.WHQJTreasureDB.dbo.ShareDetailInfo 
	WHERE ApplyDate<@StatsEndTime)
	
	-- 活跃玩家数
	SELECT @ActiveUserTotal=COUNT(UserID) FROM WHQJTreasureDBLink.WHQJTreasureDB.dbo.StreamScoreInfo 
	WHERE DateID=@DateID AND OnlineTimeCount>=60*60
	
	-- 玩家流失数
	SELECT @LossUserTotal=COUNT(UserID) FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo 
	WHERE LastLogonDate<DATEADD(mm,-1,@StatsEndTime) AND IsAndroid=0

	SELECT @LossUser=COUNT(UserID) FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo 
	WHERE LastLogonDate<DATEADD(mm,-1,@StatsEndTime) AND LastLogonDate>=DATEADD(mm,-1,@StatsStartTime) AND IsAndroid=0

	SELECT @LossPayUserTotal=COUNT(UserID) FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo 
	WHERE UserID IN (SELECT UserID FROM WHQJTreasureDBLink.WHQJTreasureDB.dbo.ShareDetailInfo) 
	AND LastLogonDate<DATEADD(mm,-1,@StatsEndTime) AND IsAndroid=0
	
	SELECT @LossPayUser=COUNT(UserID) FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo 
	WHERE UserID IN (SELECT UserID FROM WHQJTreasureDBLink.WHQJTreasureDB.dbo.ShareDetailInfo) 
	AND LastLogonDate<DATEADD(mm,-1,@StatsEndTime) AND LastLogonDate>=DATEADD(mm,-1,@StatsStartTime) AND IsAndroid=0

	-- 充值总数
	SELECT @PayAmountForCurrency=ISNULL(SUM(PayAmount),0) 
	FROM WHQJTreasureDBLink.WHQJTreasureDB.dbo.ShareDetailInfo WHERE ApplyDate<@StatsEndTime
	SET @PayAmountTotal = @PayAmountForCurrency
	-- 金币总数
	SELECT @GoldTotal=ISNULL(SUM(Score+InsureScore),0) FROM WHQJTreasureDBLink.WHQJTreasureDB.dbo.GameScoreInfo
	
	-- 货币总数
	SELECT @CurrencyTotal=ISNULL(SUM(Diamond),0) FROM WHQJTreasureDBLink.WHQJTreasureDB.dbo.UserCurrency
	WHERE UserID NOT IN (SELECT UserID FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo 
	WHERE IsAndroid=1)

	-- 平均时长
	SELECT @UserAVGOnlineTime=ISNULL(AVG(CONVERT(BIGINT,OnLineTimeCount)),0) 
	FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0

	-- 游戏税收总数
	SELECT @GameTaxTotal=ISNULL(SUM(Revenue),0) FROM WHQJTreasureDBLink.WHQJTreasureDB.dbo.StreamScoreInfo 
	WHERE DateID<=@DateID

	-- 当日游戏税收和损耗
	SELECT @GameTax=ISNULL(SUM(Revenue),0),@Waste=ISNULL(SUM(Waste),0) FROM WHQJTreasureDBLink.WHQJTreasureDB.dbo.RecordDrawInfo
	WHERE ConcludeTime<@StatsEndTime AND ConcludeTime>=@StatsStartTime

	-- 当日银行税收
	SELECT @BankTax=ISNULL(SUM(Revenue),0) FROM WHQJTreasureDBLink.WHQJTreasureDB.dbo.RecordInsure
	WHERE CollectDate<@StatsEndTime AND CollectDate>=@StatsStartTime

	-- 每日汇总数据
	IF EXISTS(SELECT DateID FROM RecordEveryDayData WHERE DateID=@DateID)
	BEGIN
		DELETE RecordEveryDayData WHERE DateID=@DateID
	END
	INSERT INTO RecordEveryDayData(DateID,UserTotal,PayUserTotal,ActiveUserTotal,LossUser,LossUserTotal,LossPayUser,LossPayUserTotal,
		PayTotalAmount,PayAmountForCurrency,GoldTotal,CurrencyTotal,GameTax,GameTaxTotal,BankTax,Waste,UserAVGOnlineTime,CollectDate)
	VALUES(@DateID,@UserTotal,@PayUserTotal,@ActiveUserTotal,@LossUser,@LossUserTotal,@LossPayUser,@LossPayUserTotal,@PayAmountTotal,
		@PayAmountForCurrency,@GoldTotal,@CurrencyTotal,@GameTax,@GameTaxTotal,@BankTax,@Waste,@UserAVGOnlineTime,GETDATE())

	-- 房间数据
	IF EXISTS(SELECT DateID FROM RecordEveryDayRoomData WHERE DateID=@DateID)
	BEGIN
		DELETE RecordEveryDayRoomData WHERE DateID=@DateID
	END

	-- 从游戏记录统计房间数据
	INSERT INTO RecordEveryDayRoomData
	SELECT @DateID AS DateID,KindID,ServerID,SUM(Waste) AS Waste,SUM(Revenue) AS Revenue,0 AS UserMedal,GETDATE() 
	FROM WHQJTreasureDBLink.WHQJTreasureDB.dbo.RecordDrawInfo 
	WHERE ConcludeTime>=@StatsStartTime AND ConcludeTime<@StatsEndTime
	GROUP BY KindID,ServerID

	-- 处理无游戏记录的房间
	INSERT INTO RecordEveryDayRoomData 
	SELECT @DateID AS DateID,GameID,ServerID,0,0,0,GETDATE() 
	FROM WHQJPlatformDBLink.WHQJPlatformDB.dbo.GameRoomInfo
	WHERE ServerID NOT IN(SELECT ServerID FROM RecordEveryDayRoomData WHERE DateID=@DateID)

	RETURN 0
END
GO

