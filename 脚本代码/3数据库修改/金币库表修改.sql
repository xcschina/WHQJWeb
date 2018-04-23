USE [WHQJTreasureDB]
GO

IF EXISTS (SELECT 1 FROM SYS.TABLES WHERE Name= 'OnLineOrder')
BEGIN
	DROP TABLE [dbo].[OnLineOrder]
END
GO

IF EXISTS (SELECT 1 FROM SYS.TABLES WHERE Name= 'CurrencyExchConfig')
BEGIN
	DROP TABLE [dbo].[CurrencyExchConfig]
END
GO

IF EXISTS (SELECT 1 FROM SYS.TABLES WHERE Name= 'GlobalSpreadInfo')
BEGIN
	DROP TABLE [dbo].[GlobalSpreadInfo]
END
GO

IF EXISTS (SELECT 1 FROM SYS.TABLES WHERE Name= 'GlobalWebInfo')
BEGIN
	DROP TABLE [dbo].[GlobalWebInfo]
END
GO

IF EXISTS (SELECT 1 FROM SYS.TABLES WHERE Name = 'AppPayConfig')
BEGIN
	/****** Object:  Table [dbo].[AppPayConfig]    Script Date: 2018/4/20 13:31:23 ******/
	DROP TABLE [dbo].[AppPayConfig]
END
GO

/****** Object:  Table [dbo].[AppPayConfig]    Script Date: 2018/4/20 13:31:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AppPayConfig](
	[ConfigID] [int] IDENTITY(1,1) NOT NULL,
	[AppleID] [nvarchar](32) NOT NULL,
	[PayName] [nvarchar](32) NOT NULL,
	[PayType] [tinyint] NOT NULL,
	[PayPrice] [decimal](18, 2) NOT NULL,
	[PayIdentity] [tinyint] NOT NULL,
	[ImageType] [tinyint] NOT NULL,
	[SortID] [int] NOT NULL,
	[ScoreType] [tinyint] NOT NULL,
	[Score] [int] NOT NULL,
	[FristPresent] [int] NOT NULL,
	[PresentScore] [int] NOT NULL,
	[ConfigTime] [datetime] NOT NULL
 CONSTRAINT [PK_AppPayConfig] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[AppPayConfig] ADD  CONSTRAINT [DF_AppPayConfig_AppleID]  DEFAULT ('') FOR [AppleID]
GO
ALTER TABLE [dbo].[AppPayConfig] ADD  CONSTRAINT [DF_AppPayConfig_PayName]  DEFAULT ('') FOR [PayName]
GO
ALTER TABLE [dbo].[AppPayConfig] ADD  CONSTRAINT [DF_AppPayConfig_PayType]  DEFAULT ((0)) FOR [PayType]
GO
ALTER TABLE [dbo].[AppPayConfig] ADD  CONSTRAINT [DF_AppPayConfig_PayPrice]  DEFAULT ((0)) FOR [PayPrice]
GO
ALTER TABLE [dbo].[AppPayConfig] ADD  CONSTRAINT [DF_AppPayConfig_PayIdentity]  DEFAULT ((0)) FOR [PayIdentity]
GO
ALTER TABLE [dbo].[AppPayConfig] ADD  CONSTRAINT [DF_AppPayConfig_ImageType]  DEFAULT ((0)) FOR [ImageType]
GO
ALTER TABLE [dbo].[AppPayConfig] ADD  CONSTRAINT [DF_AppPayConfig_SortID]  DEFAULT ((0)) FOR [SortID]
GO
ALTER TABLE [dbo].[AppPayConfig] ADD  CONSTRAINT [DF_AppPayConfig_ScoreType]  DEFAULT ((0)) FOR [ScoreType]
GO
ALTER TABLE [dbo].[AppPayConfig] ADD  CONSTRAINT [DF_AppPayConfig_Score]  DEFAULT ((0)) FOR [Score]
GO
ALTER TABLE [dbo].[AppPayConfig] ADD  CONSTRAINT [DF_AppPayConfig_FristPresent] DEFAULT ((0)) FOR [FristPresent]

ALTER TABLE [dbo].[AppPayConfig] ADD  CONSTRAINT [DF_AppPayConfig_PresentScore] DEFAULT ((0)) FOR [PresentScore]
GO
ALTER TABLE [dbo].[AppPayConfig] ADD  CONSTRAINT [DF_AppPayConfig_ConfigTime]  DEFAULT (getdate()) FOR [ConfigTime]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'ConfigID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ƻ����ֵ��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'AppleID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ��Ʒ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'PayName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ��Ʒ���ͣ�0 ��ͨ  1 ƻ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'PayType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ��Ʒ�۸�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'PayPrice'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ��־��0 ��ͨ  1  �׳䣩' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'PayIdentity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ͼƬ��Դ���ͣ�1��2��3��4��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'ImageType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'SortID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ������� �������ͣ�0����� 1����ʯ 2����Ϸ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'ScoreType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ�����ֵ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'Score'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�׳������������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'FristPresent'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����������������׳壩' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'PresentScore'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'ConfigTime'
GO

IF EXISTS (SELECT 1 FROM SYS.TABLES WHERE Name= 'OnLinePayOrder')
BEGIN
	DROP TABLE DBO.OnLinePayOrder
END
GO

/****** Object:  Table [dbo].[OnLinePayOrder]    Script Date: 2018/4/20 13:46:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OnLinePayOrder](
	[OnLineID] [int] IDENTITY(1,1) NOT NULL,
	[ConfigID] [int] NOT NULL,
	[ShareID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[Accounts] [nvarchar](31) NOT NULL,
	[NickName] [nvarchar](31) NOT NULL,
	[OrderID] [nvarchar](32) NOT NULL,
	[OrderType] [tinyint] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[ScoreType] [tinyint] NOT NULL,
	[BeforeScore] [bigint] NOT NULL,
	[Score] [int] NOT NULL,
	[OtherPresent] [int] NOT NULL,
	[OrderStatus] [tinyint] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[OrderAddress] [nvarchar](15) NOT NULL,
	[PayDate] [datetime] NULL
 CONSTRAINT [PK_OnLinePayOrder] PRIMARY KEY CLUSTERED 
(
	[OnLineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_ConfigID]  DEFAULT ((0)) FOR [ConfigID]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_ShareID]  DEFAULT ((100)) FOR [ShareID]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_UserID]  DEFAULT ((0)) FOR [UserID]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_GameID]  DEFAULT ((0)) FOR [GameID]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_Accounts]  DEFAULT ('') FOR [Accounts]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_NickName]  DEFAULT ('') FOR [NickName]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_OrderID]  DEFAULT ('') FOR [OrderID]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_OrderType]  DEFAULT ((0)) FOR [OrderType]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_ScoreType]  DEFAULT ((0)) FOR [ScoreType]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_BeforeScore]  DEFAULT ((0)) FOR [BeforeScore]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_Score]  DEFAULT ((0)) FOR [Score]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_OtherPresent]  DEFAULT ((0)) FOR [OtherPresent]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_OrderStatus]  DEFAULT ((0)) FOR [OrderStatus]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_OrderDate]  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[OnLinePayOrder] ADD  CONSTRAINT [DF_OnLinePayOrder_OrderAddress]  DEFAULT ('') FOR [OrderAddress]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'OnLineID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ���ñ�ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'ConfigID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ��ʽ������GlobalShareInfo��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'ShareID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'UserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��Ϸ��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'GameID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û��˺�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'Accounts'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û��ǳ�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'NickName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'OrderID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������ͣ�0 ��ͨ��ֵ  1 ƻ����ֵ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'OrderType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'Amount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ���ͣ�0����� 1����ʯ 2����Ϸ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'ScoreType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵǰ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'BeforeScore'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'Score'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ����������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'OtherPresent'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����״̬��0 δ֧��  1 ��֧����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'OrderStatus'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'OrderDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ַ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'OrderAddress'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'OnLinePayOrder', @level2type=N'COLUMN',@level2name=N'PayDate'
GO


