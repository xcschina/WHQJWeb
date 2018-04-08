----------------------------------------------------------------------
-- ʱ�䣺2011-10-20
-- ��;�����ݻ���ͳ�ơ�
----------------------------------------------------------------------
USE WHQJTreasureDB
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PM_StatInfo') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PM_StatInfo
GO

----------------------------------------------------------------------
CREATE PROC NET_PM_StatInfo
			
WITH ENCRYPTION AS

BEGIN
	-- ��������
	SET NOCOUNT ON;	
	--�û�ͳ��
	DECLARE @OnLineCount BIGINT		--��������
	DECLARE @DisenableCount BIGINT		--ͣȨ�û�
	DECLARE @AllCount BIGINT			--ע��������
	DECLARE @MobileRegister BIGINT		--�ֻ�ע��������
	DECLARE @WebRegister BIGINT		--WEBע��������
	DECLARE @H5Register BIGINT		--H5ע��������
	SELECT  TOP 1 @OnLineCount=ISNULL(OnLineCountSum,0) FROM WHQJPlatformDBLink.WHQJPlatformDB.dbo.OnLineStreamInfo ORDER BY InsertDateTime DESC
	SELECT  @DisenableCount=COUNT(UserID) FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo WHERE Nullity = 1
	SELECT  @AllCount=COUNT(UserID) FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo
	SELECT @MobileRegister=COUNT(UserID) FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo WHERE RegisterOrigin>10 AND RegisterOrigin<80
	SELECT @WebRegister=COUNT(UserID) FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo WHERE RegisterOrigin>=80 AND RegisterOrigin<90
	SELECT @H5Register=COUNT(UserID) FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo WHERE RegisterOrigin=90

	--���ͳ��
	DECLARE @Score BIGINT		--���Ͻ������
	DECLARE @InsureScore BIGINT	--��������
	DECLARE @AllScore BIGINT
	SELECT  @Score=ISNULL(SUM(Score),0),@InsureScore=ISNULL(SUM(InsureScore),0),@AllScore=ISNULL(SUM(Score+InsureScore),0) 
	FROM GameScoreInfo(NOLOCK)

	--��ʯͳ��
	DECLARE @FKAdminPresent BIGINT	--��̨������ʯ
	DECLARE @FKCreateRoom BIGINT	--��������������ʯ
	DECLARE @FKAACreateRoom BIGINT	--����AA����������ʯ
	DECLARE @FKExchScore BIGINT		--�һ���Ϸ��������ʯ
	DECLARE @FKRMBPay BIGINT		--��ֵ��ʯ
	DECLARE @FKTotal BIGINT			--ƽ̨��ʯ����
	SELECT @FKTotal = ISNULL(SUM(Diamond),0) FROM UserCurrency(NOLOCK)
	SELECT @FKAdminPresent = ISNULL(SUM(AddDiamond),0) FROM WHQJRecordDBLink.WHQJRecordDB.dbo.RecordGrantDiamond
	SELECT @FKExchScore = ISNULL(SUM(ExchDiamond),0) FROM WHQJRecordDBLink.WHQJRecordDB.dbo.RecordCurrencyExch
	SELECT @FKCreateRoom = ISNULL(SUM(CreateTableFee),0) FROM WHQJPlatformDBLink.WHQJPlatformDB.dbo.StreamCreateTableFeeInfo WHERE PayMode=0
	SELECT @FKAACreateRoom = ISNULL(SUM(Diamond),0) FROM WHQJRecordDBLink.WHQJRecordDB.dbo.RecordGameDiamond WHERE TypeID = 1
	SELECT @FKRMBPay = ISNULL(SUM(Diamond),0) FROM OnLinePayOrder WHERE Diamond > 0 AND OrderStatus = 1
	
	--����ͳ��
	DECLARE @RegPresent BIGINT				--ע������(1)
	DECLARE @SMPresent BIGINT				--ʵ����֤(8)
	DECLARE @WebPresent BIGINT				--��̨����
	DECLARE @ExchGold BIGINT				--�һ����ý��
	SELECT @RegPresent=ISNULL(SUM(CONVERT(BIGINT,[PresentScore])),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=1
	SELECT @SMPresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=8
	--SELECT @LotteryPresent=ISNULL(SUM([PresentScore]),0) FROM [dbo].[StreamPresentInfo](NOLOCK) WHERE [TypeID]=14
	SELECT @WebPresent=ISNULL(SUM(CONVERT(BIGINT,AddGold)),0) FROM WHQJRecordDBLink.WHQJRecordDB.dbo.RecordGrantTreasure
	SELECT @ExchGold = ISNULL(SUM(CONVERT(BIGINT,PresentGold)),0) FROM WHQJRecordDBLink.WHQJRecordDB.dbo.RecordCurrencyExch
	
	--˰��ͳ��
	DECLARE @Revenue BIGINT			--˰������
	DECLARE @GameRevenue BIGINT			--��Ϸ˰��
	DECLARE @TransferRevenue BIGINT	--ת��˰��
	SELECT @GameRevenue=ISNULL(SUM(Revenue),0) FROM StreamScoreInfo(NOLOCK)
	SELECT @TransferRevenue=ISNULL(SUM(Revenue),0) FROM RecordInsure(NOLOCK)
	SET @Revenue = @GameRevenue+@TransferRevenue
	--���ͳ��
	DECLARE @Waste BIGINT   --�������
	SELECT @Waste=ISNULL(SUM(Waste),0) FROM RecordDrawInfo(NOLOCK)

	--����
	SELECT  @OnLineCount AS	OnLineCount,				--��������
			@DisenableCount AS DisenableCount,			--ͣȨ�û�
			@AllCount AS AllCount,						--ע��������
			@MobileRegister AS MobileRegister,			--�ֻ���ע��������
			@WebRegister AS WebRegister,				--Webע��������
			@H5Register AS H5Register,					--H5ע��������
			@Score AS Score,							--���Ͻ������
			@InsureScore AS InsureScore,				--��������
			@AllScore AS AllScore,						--�������

			@FKAdminPresent AS FKAdminPresent,			--��̨������ʯ
			@FKCreateRoom AS FKCreateRoom,				--��������������ʯ
			@FKAACreateRoom AS FKAACreateRoom,			--����AA����������ʯ
			@FKExchScore AS FKExchScore,				--�һ���Ϸ��������ʯ
			@FKRMBPay AS FKRMBPay,						--����ҹ�����ʯ
			@FKTotal AS FKTotal,						--ƽ̨��ʯ����
			@FKAdminPresent+@FKRMBPay AS TotalDiamondUp,
			@FKCreateRoom+@FKAACreateRoom+@FKExchScore AS TotalDiamondDown,

			@RegPresent AS RegPresent,					--ע������
			--@AgentRegPresent AS AgentRegPresent,		--����ע������
			--@DBPresent AS DBPresent,					--�ͱ�����
			--@QDPresent AS QDPresent,					--ǩ������
			--@YBPresent AS YBPresent,					--Ԫ���һ�
			--@MLPresent AS MLPresent,					--�����һ�
			--@OnlinePresent AS OnlinePresent,			--����ʱ������
			--@RWPresent AS RWPresent,					--������
			--@SMPresent AS SMPresent,					--ʵ����֤
			--@DayPresent AS DayPresent,					--��Աÿ���ͽ�
			--@MatchPresent AS MatchPresent,				--��������
			--@DJPresent AS DJPresent,					--�ȼ�����
			--@SharePresent AS SharePresent,				--��������
			--@LotteryPresent AS LotteryPresent,			--ת������
			@WebPresent AS WebPresent,					--��̨����
			@ExchGold AS ExchGold,
			@RegPresent+@WebPresent+@ExchGold AS TotalGoldUp,		--������

			@Revenue AS Revenue,						--˰������
			@TransferRevenue AS TransferRevenue,		--ת��˰��	
			@GameRevenue AS GameRevenue,		--ת��˰��	
			@Waste AS Waste								--�������
END































