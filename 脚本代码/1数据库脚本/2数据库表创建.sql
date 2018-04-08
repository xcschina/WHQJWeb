USE [WHQJNativeWebDB]
GO

/****** Object:  Table [dbo].[Ads]    Script Date: 2017/7/17 9:35:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Ads](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[ResourceURL] [nvarchar](500) NOT NULL,
	[LinkURL] [nvarchar](500) NOT NULL,
	[Type] [tinyint] NOT NULL,
	[SortID] [int] NOT NULL,
	[Remark] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_Ads] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Ads] ADD  CONSTRAINT [DF_AdImage_Title]  DEFAULT ('') FOR [Title]
GO

ALTER TABLE [dbo].[Ads] ADD  CONSTRAINT [DF_Table_1_ImageUrl]  DEFAULT ('') FOR [ResourceURL]
GO

ALTER TABLE [dbo].[Ads] ADD  CONSTRAINT [DF_AdImage_LinkURL]  DEFAULT ('') FOR [LinkURL]
GO

ALTER TABLE [dbo].[Ads] ADD  CONSTRAINT [DF_AdImage_Type]  DEFAULT ((0)) FOR [Type]
GO

ALTER TABLE [dbo].[Ads] ADD  CONSTRAINT [DF_AdImage_Remark]  DEFAULT ('') FOR [Remark]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Ads', @level2type=N'COLUMN',@level2name=N'ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ͼƬ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Ads', @level2type=N'COLUMN',@level2name=N'Title'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��Դ·��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Ads', @level2type=N'COLUMN',@level2name=N'ResourceURL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���ӵ�ַ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Ads', @level2type=N'COLUMN',@level2name=N'LinkURL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���ͼƬ���� 0:��վ��ҳ�ֻ���� 1:���Ź�����ͼ 2:��ϵ���ǹ��ͼ 3���ֻ��������λ 4���ֻ������������λ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Ads', @level2type=N'COLUMN',@level2name=N'Type'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Ads', @level2type=N'COLUMN',@level2name=N'SortID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ע��Ϣ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Ads', @level2type=N'COLUMN',@level2name=N'Remark'
GO

/****** Object:  Table [dbo].[CacheConsumeRank]    Script Date: 2017/7/13 17:52:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CacheConsumeRank](
	[DateID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[NickName] [nvarchar](31) NOT NULL,
	[FaceUrl] [nvarchar](500) NOT NULL,
	[SystemFaceID] [int] NOT NULL,
	[RankNum] [int] NOT NULL,
	[Diamond] [bigint] NOT NULL,
	[CollectDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CacheConsumeRank] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[CacheConsumeRank] ADD  CONSTRAINT [DF_CacheConsumeRank_DateID]  DEFAULT ((0)) FOR [DateID]
GO

ALTER TABLE [dbo].[CacheConsumeRank] ADD  CONSTRAINT [DF_CacheConsumeRank_UserID]  DEFAULT ((0)) FOR [UserID]
GO

ALTER TABLE [dbo].[CacheConsumeRank] ADD  CONSTRAINT [DF_CacheConsumeRank_GameID]  DEFAULT ((0)) FOR [GameID]
GO

ALTER TABLE [dbo].[CacheConsumeRank] ADD  CONSTRAINT [DF_CacheConsumeRank_NickName]  DEFAULT ('') FOR [NickName]
GO

ALTER TABLE [dbo].[CacheConsumeRank] ADD  CONSTRAINT [DF_CacheConsumeRank_CustomFaceID]  DEFAULT ('') FOR [FaceUrl]
GO

ALTER TABLE [dbo].[CacheConsumeRank] ADD  CONSTRAINT [DF_CacheConsumeRank_SystemFaceID]  DEFAULT ((0)) FOR [SystemFaceID]
GO

ALTER TABLE [dbo].[CacheConsumeRank] ADD  CONSTRAINT [DF_CacheConsumeRank_RankNum]  DEFAULT ((0)) FOR [RankNum]
GO

ALTER TABLE [dbo].[CacheConsumeRank] ADD  CONSTRAINT [DF_CacheConsumeRank_Diamond]  DEFAULT ((0)) FOR [Diamond]
GO

ALTER TABLE [dbo].[CacheConsumeRank] ADD  CONSTRAINT [DF_CacheConsumeRank_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ʱ���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheConsumeRank', @level2type=N'COLUMN',@level2name=N'DateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheConsumeRank', @level2type=N'COLUMN',@level2name=N'UserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��Ϸ��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheConsumeRank', @level2type=N'COLUMN',@level2name=N'GameID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û��ǳ�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheConsumeRank', @level2type=N'COLUMN',@level2name=N'NickName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Զ���ͷ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheConsumeRank', @level2type=N'COLUMN',@level2name=N'FaceUrl'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ϵͳͷ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheConsumeRank', @level2type=N'COLUMN',@level2name=N'SystemFaceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheConsumeRank', @level2type=N'COLUMN',@level2name=N'RankNum'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ʯ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheConsumeRank', @level2type=N'COLUMN',@level2name=N'Diamond'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ͳ��ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheConsumeRank', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO

/****** Object:  Table [dbo].[CacheRankValue]    Script Date: 2017/7/13 17:52:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CacheRankValue](
	[RankID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[TypeID] [tinyint] NOT NULL,
	[RankValue] [bigint] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[CacheRankValue] ADD  CONSTRAINT [DF_CacheRankValue_UserID]  DEFAULT ((0)) FOR [UserID]
GO

ALTER TABLE [dbo].[CacheRankValue] ADD  CONSTRAINT [DF_CacheRankValue_TypeID]  DEFAULT ((0)) FOR [TypeID]
GO

ALTER TABLE [dbo].[CacheRankValue] ADD  CONSTRAINT [DF_CacheRankValue_RankValue]  DEFAULT ((0)) FOR [RankValue]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheRankValue', @level2type=N'COLUMN',@level2name=N'RankID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheRankValue', @level2type=N'COLUMN',@level2name=N'UserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���а�����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheRankValue', @level2type=N'COLUMN',@level2name=N'TypeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����ֵ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheRankValue', @level2type=N'COLUMN',@level2name=N'RankValue'
GO

/****** Object:  Table [dbo].[CacheScoreRank]    Script Date: 2017/7/13 17:53:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CacheScoreRank](
	[DateID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[NickName] [nvarchar](31) NOT NULL,
	[FaceUrl] [nvarchar](500) NOT NULL,
	[SystemFaceID] [int] NOT NULL,
	[RankNum] [int] NOT NULL,
	[Score] [bigint] NOT NULL,
	[CollectDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CacheScoreRank] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[CacheScoreRank] ADD  CONSTRAINT [DF_CacheScoreRank_DateID]  DEFAULT ((0)) FOR [DateID]
GO

ALTER TABLE [dbo].[CacheScoreRank] ADD  CONSTRAINT [DF_CacheScoreRank_UserID]  DEFAULT ((0)) FOR [UserID]
GO

ALTER TABLE [dbo].[CacheScoreRank] ADD  CONSTRAINT [DF_CacheScoreRank_GameID]  DEFAULT ((0)) FOR [GameID]
GO

ALTER TABLE [dbo].[CacheScoreRank] ADD  CONSTRAINT [DF_CacheScoreRank_NickName]  DEFAULT ('') FOR [NickName]
GO

ALTER TABLE [dbo].[CacheScoreRank] ADD  CONSTRAINT [DF_CacheScoreRank_CustomFaceID]  DEFAULT ('') FOR [FaceUrl]
GO

ALTER TABLE [dbo].[CacheScoreRank] ADD  CONSTRAINT [DF_CacheScoreRank_SystemFaceID]  DEFAULT ((0)) FOR [SystemFaceID]
GO

ALTER TABLE [dbo].[CacheScoreRank] ADD  CONSTRAINT [DF_CacheScoreRank_RankNum]  DEFAULT ((0)) FOR [RankNum]
GO

ALTER TABLE [dbo].[CacheScoreRank] ADD  CONSTRAINT [DF_CacheScoreRank_Score]  DEFAULT ((0)) FOR [Score]
GO

ALTER TABLE [dbo].[CacheScoreRank] ADD  CONSTRAINT [DF_CacheScoreRank_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ʱ���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheScoreRank', @level2type=N'COLUMN',@level2name=N'DateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheScoreRank', @level2type=N'COLUMN',@level2name=N'UserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��Ϸ��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheScoreRank', @level2type=N'COLUMN',@level2name=N'GameID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û��ǳ�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheScoreRank', @level2type=N'COLUMN',@level2name=N'NickName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Զ���ͷ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheScoreRank', @level2type=N'COLUMN',@level2name=N'FaceUrl'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ϵͳͷ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheScoreRank', @level2type=N'COLUMN',@level2name=N'SystemFaceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheScoreRank', @level2type=N'COLUMN',@level2name=N'RankNum'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��Ӯ�ɼ�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheScoreRank', @level2type=N'COLUMN',@level2name=N'Score'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ͳ��ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheScoreRank', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO

/****** Object:  Table [dbo].[CacheWealthRank]    Script Date: 2017/7/13 17:53:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CacheWealthRank](
	[DateID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[NickName] [nvarchar](31) NOT NULL,
	[FaceUrl] [nvarchar](500) NOT NULL,
	[SystemFaceID] [int] NOT NULL,
	[RankNum] [int] NOT NULL,
	[Diamond] [bigint] NOT NULL,
	[CollectDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CacheWealthRank] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[CacheWealthRank] ADD  CONSTRAINT [DF_CacheWealthRank_DateID]  DEFAULT ((0)) FOR [DateID]
GO

ALTER TABLE [dbo].[CacheWealthRank] ADD  CONSTRAINT [DF_CacheWealthRank_UserID]  DEFAULT ((0)) FOR [UserID]
GO

ALTER TABLE [dbo].[CacheWealthRank] ADD  CONSTRAINT [DF_CacheWealthRank_GameID]  DEFAULT ((0)) FOR [GameID]
GO

ALTER TABLE [dbo].[CacheWealthRank] ADD  CONSTRAINT [DF_CacheWealthRank_NickName]  DEFAULT ('') FOR [NickName]
GO

ALTER TABLE [dbo].[CacheWealthRank] ADD  CONSTRAINT [DF_CacheWealthRank_CustomFaceID]  DEFAULT ('') FOR [FaceUrl]
GO

ALTER TABLE [dbo].[CacheWealthRank] ADD  CONSTRAINT [DF_CacheWealthRank_SystemFaceID]  DEFAULT ((0)) FOR [SystemFaceID]
GO

ALTER TABLE [dbo].[CacheWealthRank] ADD  CONSTRAINT [DF_CacheWealthRank_RankNum]  DEFAULT ((0)) FOR [RankNum]
GO

ALTER TABLE [dbo].[CacheWealthRank] ADD  CONSTRAINT [DF_CacheWealthRank_Diamond]  DEFAULT ((0)) FOR [Diamond]
GO

ALTER TABLE [dbo].[CacheWealthRank] ADD  CONSTRAINT [DF_CacheWealthRank_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ʱ���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheWealthRank', @level2type=N'COLUMN',@level2name=N'DateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheWealthRank', @level2type=N'COLUMN',@level2name=N'UserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��Ϸ��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheWealthRank', @level2type=N'COLUMN',@level2name=N'GameID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û��ǳ�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheWealthRank', @level2type=N'COLUMN',@level2name=N'NickName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Զ���ͷ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheWealthRank', @level2type=N'COLUMN',@level2name=N'FaceUrl'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ϵͳͷ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheWealthRank', @level2type=N'COLUMN',@level2name=N'SystemFaceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheWealthRank', @level2type=N'COLUMN',@level2name=N'RankNum'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ʯ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheWealthRank', @level2type=N'COLUMN',@level2name=N'Diamond'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ͳ��ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'CacheWealthRank', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO

/****** Object:  Table [dbo].[ConfigInfo]    Script Date: 2017/7/13 17:53:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ConfigInfo](
	[ConfigID] [int] IDENTITY(1,1) NOT NULL,
	[ConfigKey] [nvarchar](32) NOT NULL,
	[ConfigName] [nvarchar](64) NOT NULL,
	[ConfigString] [nvarchar](512) NOT NULL,
	[Field1] [nvarchar](128) NOT NULL,
	[Field2] [nvarchar](128) NOT NULL,
	[Field3] [nvarchar](128) NOT NULL,
	[Field4] [nvarchar](128) NOT NULL,
	[Field5] [nvarchar](128) NOT NULL,
	[Field6] [nvarchar](128) NOT NULL,
	[Field7] [nvarchar](128) NOT NULL,
	[Field8] [text] NOT NULL,
	[SortID] [int] NOT NULL,
 CONSTRAINT [PK_SytemConfigInfo] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[ConfigInfo] ADD  CONSTRAINT [DF_PublicConfig_ConfigName]  DEFAULT ('') FOR [ConfigKey]
GO

ALTER TABLE [dbo].[ConfigInfo] ADD  CONSTRAINT [DF_PublicConfig_ConfigName_1]  DEFAULT ('') FOR [ConfigName]
GO

ALTER TABLE [dbo].[ConfigInfo] ADD  CONSTRAINT [DF_PublicConfig_Description]  DEFAULT ('') FOR [ConfigString]
GO

ALTER TABLE [dbo].[ConfigInfo] ADD  CONSTRAINT [DF_PublicConfig_Field1]  DEFAULT ('') FOR [Field1]
GO

ALTER TABLE [dbo].[ConfigInfo] ADD  CONSTRAINT [DF_PublicConfig_Field2]  DEFAULT ('') FOR [Field2]
GO

ALTER TABLE [dbo].[ConfigInfo] ADD  CONSTRAINT [DF_PublicConfig_Field3]  DEFAULT ('') FOR [Field3]
GO

ALTER TABLE [dbo].[ConfigInfo] ADD  CONSTRAINT [DF_PublicConfig_Field4]  DEFAULT ('') FOR [Field4]
GO

ALTER TABLE [dbo].[ConfigInfo] ADD  CONSTRAINT [DF_PublicConfig_Field5]  DEFAULT ('') FOR [Field5]
GO

ALTER TABLE [dbo].[ConfigInfo] ADD  CONSTRAINT [DF_PublicConfig_Field6]  DEFAULT ('') FOR [Field6]
GO

ALTER TABLE [dbo].[ConfigInfo] ADD  CONSTRAINT [DF_PublicConfig_Field7]  DEFAULT ('') FOR [Field7]
GO

ALTER TABLE [dbo].[ConfigInfo] ADD  CONSTRAINT [DF_PublicConfig_Field8]  DEFAULT ('') FOR [Field8]
GO

ALTER TABLE [dbo].[ConfigInfo] ADD  CONSTRAINT [DF_ConfigInfo_SortID]  DEFAULT ((0)) FOR [SortID]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���ñ�ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfigInfo', @level2type=N'COLUMN',@level2name=N'ConfigID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����KEY' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfigInfo', @level2type=N'COLUMN',@level2name=N'ConfigKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfigInfo', @level2type=N'COLUMN',@level2name=N'ConfigName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����˵��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfigInfo', @level2type=N'COLUMN',@level2name=N'ConfigString'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfigInfo', @level2type=N'COLUMN',@level2name=N'SortID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������ñ���ϵͳ��������Ϣ���������ڴ˱�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ConfigInfo'
GO

/****** Object:  Table [dbo].[GameRule]    Script Date: 2017/8/30 18:53:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[GameRule](
	[KindID] [int] NOT NULL,
	[KindName] [nvarchar](32) NOT NULL,
	[KindIcon] [nvarchar](100) NOT NULL,
	[KindIntro] [nvarchar](500) NOT NULL,
	[KindRule] [ntext] NOT NULL,
	[Nullity] [tinyint] NOT NULL,
	[CollectDate] [datetime] NOT NULL,
 CONSTRAINT [PK_GameRule] PRIMARY KEY CLUSTERED 
(
	[KindID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[GameRule] ADD  CONSTRAINT [DF_GameRule_KindID]  DEFAULT ((0)) FOR [KindID]
GO

ALTER TABLE [dbo].[GameRule] ADD  CONSTRAINT [DF_GameRule_KindName]  DEFAULT ('') FOR [KindName]
GO

ALTER TABLE [dbo].[GameRule] ADD  CONSTRAINT [DF_GameRule_KindIcon]  DEFAULT ('') FOR [KindIcon]
GO

ALTER TABLE [dbo].[GameRule] ADD  CONSTRAINT [DF_GameRule_KindIntro]  DEFAULT ('') FOR [KindIntro]
GO

ALTER TABLE [dbo].[GameRule] ADD  CONSTRAINT [DF_GameRule_KindRule]  DEFAULT ('') FOR [KindRule]
GO

ALTER TABLE [dbo].[GameRule] ADD  CONSTRAINT [DF_GameRule_Nullity]  DEFAULT ((0)) FOR [Nullity]
GO

ALTER TABLE [dbo].[GameRule] ADD  CONSTRAINT [DF_GameRule_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��Ϸ��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRule', @level2type=N'COLUMN',@level2name=N'KindID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��Ϸ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRule', @level2type=N'COLUMN',@level2name=N'KindName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��Ϸͼ��·��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRule', @level2type=N'COLUMN',@level2name=N'KindIcon'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��Ϸ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRule', @level2type=N'COLUMN',@level2name=N'KindIntro'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��Ϸ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRule', @level2type=N'COLUMN',@level2name=N'KindRule'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Ƿ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRule', @level2type=N'COLUMN',@level2name=N'Nullity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRule', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO


/****** Object:  Table [dbo].[RankingConfig]    Script Date: 2017/7/13 17:54:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RankingConfig](
	[ConfigID] [int] IDENTITY(1,1) NOT NULL,
	[TypeID] [tinyint] NOT NULL,
	[RankID] [int] NOT NULL,
	[Diamond] [int] NOT NULL,
	[ValidityTime] [int] NOT NULL,
	[UpdateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_RankingConfig] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[RankingConfig] ADD  CONSTRAINT [DF_RankingConfig_TypeID]  DEFAULT ((1)) FOR [TypeID]
GO

ALTER TABLE [dbo].[RankingConfig] ADD  CONSTRAINT [DF_RankingConfig_RankID]  DEFAULT ((0)) FOR [RankID]
GO

ALTER TABLE [dbo].[RankingConfig] ADD  CONSTRAINT [DF_RankingConfig_Diamond]  DEFAULT ((0)) FOR [Diamond]
GO

ALTER TABLE [dbo].[RankingConfig] ADD  CONSTRAINT [DF_RankingConfig_ValidityTime]  DEFAULT ((0)) FOR [ValidityTime]
GO

ALTER TABLE [dbo].[RankingConfig] ADD  CONSTRAINT [DF_RankingConfig_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���ñ�ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RankingConfig', @level2type=N'COLUMN',@level2name=N'ConfigID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���а����ͣ�1���Ƹ����а�  2���������а�  4��ս�����а�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RankingConfig', @level2type=N'COLUMN',@level2name=N'TypeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���а�����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RankingConfig', @level2type=N'COLUMN',@level2name=N'RankID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ʯ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RankingConfig', @level2type=N'COLUMN',@level2name=N'Diamond'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����������Ч������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RankingConfig', @level2type=N'COLUMN',@level2name=N'ValidityTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�޸�ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RankingConfig', @level2type=N'COLUMN',@level2name=N'UpdateTime'
GO

/****** Object:  Table [dbo].[RecordRankingRecevie]    Script Date: 2017/7/13 17:54:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RecordRankingRecevie](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[DateID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[GameID] [int] NOT NULL,
	[NickName] [nvarchar](31) NOT NULL,
	[SystemFaceID] [int] NOT NULL,
	[FaceUrl] [nvarchar](500) NOT NULL,
	[TypeID] [int] NOT NULL,
	[RankID] [int] NOT NULL,
	[RankValue] [bigint] NOT NULL,
	[Diamond] [int] NOT NULL,
	[ValidityTime] [datetime] NOT NULL,
	[ReceiveState] [bit] NOT NULL,
	[BeforeDiamond] [bigint] NOT NULL,
	[ReceiveIP] [nvarchar](15) NOT NULL,
	[ReceiveTime] [datetime] NULL,
	[CollectDate] [datetime] NOT NULL,
 CONSTRAINT [PK_RecordRankingRecevie] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_DateID]  DEFAULT ((0)) FOR [DateID]
GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_UserID]  DEFAULT ((0)) FOR [UserID]
GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_GameID]  DEFAULT ((0)) FOR [GameID]
GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_NickName]  DEFAULT ('') FOR [NickName]
GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_SystemFaceID]  DEFAULT ((0)) FOR [SystemFaceID]
GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_CustomFaceID]  DEFAULT ('') FOR [FaceUrl]
GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_TypeID]  DEFAULT ((0)) FOR [TypeID]
GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_RankID]  DEFAULT ((0)) FOR [RankID]
GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_RankValue]  DEFAULT ((0)) FOR [RankValue]
GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_Diamond]  DEFAULT ((0)) FOR [Diamond]
GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_ValidityTime]  DEFAULT (getdate()) FOR [ValidityTime]
GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_ReceiveState]  DEFAULT ((0)) FOR [ReceiveState]
GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_BeforeDiamond]  DEFAULT ((0)) FOR [BeforeDiamond]
GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_ReceiveIP]  DEFAULT ('') FOR [ReceiveIP]
GO

ALTER TABLE [dbo].[RecordRankingRecevie] ADD  CONSTRAINT [DF_RecordRankingRecevie_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��¼��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'RecordID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���ڱ�ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'DateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'UserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��Ϸ��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'GameID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û��ǳ�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'NickName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ϵͳͷ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'SystemFaceID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Զ���ͷ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'FaceUrl'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���а�����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'TypeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���а�����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'RankID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ֵ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'RankValue'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ʯ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'Diamond'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ȡ�Ľ���ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'ValidityTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ȡ״̬��0 δ��ȡ 1����ȡ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'ReceiveState'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ȡǰ��ʯ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'BeforeDiamond'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ȡ��ַ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'ReceiveIP'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��¼ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordRankingRecevie', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO

/****** Object:  Table [dbo].[SystemNotice]    Script Date: 2017/8/30 18:53:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SystemNotice](
	[NoticeID] [int] IDENTITY(1,1) NOT NULL,
	[NoticeTitle] [nvarchar](50) NOT NULL,
	[MoblieContent] [nvarchar](1000) NOT NULL,
	[WebContent] [ntext] NOT NULL,
	[SortID] [int] NOT NULL,
	[Publisher] [nvarchar](32) NOT NULL,
	[PublisherTime] [datetime] NOT NULL,
	[IsHot] [bit] NOT NULL,
	[IsTop] [bit] NOT NULL,
	[Nullity] [bit] NOT NULL,
 CONSTRAINT [PK_SystemNotice] PRIMARY KEY CLUSTERED 
(
	[NoticeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[SystemNotice] ADD  CONSTRAINT [DF_SystemNotice_NoticeTitle]  DEFAULT ('') FOR [NoticeTitle]
GO

ALTER TABLE [dbo].[SystemNotice] ADD  CONSTRAINT [DF_SystemNotice_NoticeContent]  DEFAULT ('') FOR [MoblieContent]
GO

ALTER TABLE [dbo].[SystemNotice] ADD  CONSTRAINT [DF_SystemNotice_WebContent]  DEFAULT ('') FOR [WebContent]
GO

ALTER TABLE [dbo].[SystemNotice] ADD  CONSTRAINT [DF_SystemNotice_SortID]  DEFAULT ((0)) FOR [SortID]
GO

ALTER TABLE [dbo].[SystemNotice] ADD  CONSTRAINT [DF_SystemNotice_Publisher]  DEFAULT ('') FOR [Publisher]
GO

ALTER TABLE [dbo].[SystemNotice] ADD  CONSTRAINT [DF_SystemNotice_PublisherTime]  DEFAULT (getdate()) FOR [PublisherTime]
GO

ALTER TABLE [dbo].[SystemNotice] ADD  CONSTRAINT [DF_SystemNotice_IsHot]  DEFAULT ((0)) FOR [IsHot]
GO

ALTER TABLE [dbo].[SystemNotice] ADD  CONSTRAINT [DF_SystemNotice_IsTop]  DEFAULT ((0)) FOR [IsTop]
GO

ALTER TABLE [dbo].[SystemNotice] ADD  CONSTRAINT [DF_SystemNotice_Nullity]  DEFAULT ((0)) FOR [Nullity]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemNotice', @level2type=N'COLUMN',@level2name=N'NoticeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemNotice', @level2type=N'COLUMN',@level2name=N'NoticeTitle'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�ֻ�����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemNotice', @level2type=N'COLUMN',@level2name=N'MoblieContent'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��վ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemNotice', @level2type=N'COLUMN',@level2name=N'WebContent'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemNotice', @level2type=N'COLUMN',@level2name=N'SortID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemNotice', @level2type=N'COLUMN',@level2name=N'Publisher'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemNotice', @level2type=N'COLUMN',@level2name=N'PublisherTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Ƿ�����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemNotice', @level2type=N'COLUMN',@level2name=N'IsHot'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Ƿ��ö�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemNotice', @level2type=N'COLUMN',@level2name=N'IsTop'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Ƿ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemNotice', @level2type=N'COLUMN',@level2name=N'Nullity'
GO

USE [WHQJPlatformManagerDB]
GO

/****** Object:  Table [dbo].[Base_Module]    Script Date: 2017/7/13 17:55:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Base_Module](
	[ModuleID] [int] NOT NULL,
	[ParentID] [int] NOT NULL,
	[Title] [nvarchar](20) NOT NULL,
	[Link] [nvarchar](256) NOT NULL,
	[OrderNo] [int] NOT NULL,
	[Nullity] [bit] NOT NULL,
	[IsMenu] [bit] NOT NULL,
	[Description] [nvarchar](256) NOT NULL,
	[ManagerPopedom] [int] NOT NULL,
 CONSTRAINT [PK_Base_Module] PRIMARY KEY CLUSTERED 
(
	[ModuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Base_Module] ADD  CONSTRAINT [DF_Base_Module_ParentID]  DEFAULT ((0)) FOR [ParentID]
GO

ALTER TABLE [dbo].[Base_Module] ADD  CONSTRAINT [DF_Base_Module_Title]  DEFAULT ('') FOR [Title]
GO

ALTER TABLE [dbo].[Base_Module] ADD  CONSTRAINT [DF_Base_Module_Link]  DEFAULT ('') FOR [Link]
GO

ALTER TABLE [dbo].[Base_Module] ADD  CONSTRAINT [DF_Base_Module_OrderNo]  DEFAULT ((0)) FOR [OrderNo]
GO

ALTER TABLE [dbo].[Base_Module] ADD  CONSTRAINT [DF_Base_Module_IsMenu]  DEFAULT ((0)) FOR [IsMenu]
GO

ALTER TABLE [dbo].[Base_Module] ADD  CONSTRAINT [DF_Base_Module_Description]  DEFAULT ('') FOR [Description]
GO

ALTER TABLE [dbo].[Base_Module] ADD  CONSTRAINT [DF_Base_Module_ManagerPopedom]  DEFAULT ((0)) FOR [ManagerPopedom]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ģ���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Module', @level2type=N'COLUMN',@level2name=N'ModuleID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�ϼ�ģ���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Module', @level2type=N'COLUMN',@level2name=N'ParentID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ģ������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Module', @level2type=N'COLUMN',@level2name=N'Title'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ģ�����ӵ�ַ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Module', @level2type=N'COLUMN',@level2name=N'Link'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ֵ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Module', @level2type=N'COLUMN',@level2name=N'OrderNo'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Ƿ����� 0: ���� ; 1:����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Module', @level2type=N'COLUMN',@level2name=N'Nullity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Ƿ�˵� 0:���� ; 1:��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Module', @level2type=N'COLUMN',@level2name=N'IsMenu'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ģ��˵��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Module', @level2type=N'COLUMN',@level2name=N'Description'
GO

/****** Object:  Table [dbo].[Base_ModulePermission]    Script Date: 2017/7/13 17:55:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Base_ModulePermission](
	[ModuleID] [int] NOT NULL,
	[PermissionTitle] [nvarchar](128) NOT NULL,
	[PermissionValue] [bigint] NOT NULL,
	[Nullity] [tinyint] NOT NULL,
	[StateFlag] [int] NOT NULL,
	[ParentID] [int] NOT NULL,
 CONSTRAINT [PK_Base_ModulePermission_1] PRIMARY KEY CLUSTERED 
(
	[ModuleID] ASC,
	[PermissionValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ģ���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_ModulePermission', @level2type=N'COLUMN',@level2name=N'ModuleID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ģ������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_ModulePermission', @level2type=N'COLUMN',@level2name=N'PermissionTitle'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֹ��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_ModulePermission', @level2type=N'COLUMN',@level2name=N'Nullity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ģ���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_ModulePermission', @level2type=N'COLUMN',@level2name=N'ParentID'
GO

/****** Object:  Table [dbo].[Base_RolePermission]    Script Date: 2017/7/13 17:56:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Base_RolePermission](
	[RoleID] [int] NOT NULL,
	[ModuleID] [int] NOT NULL,
	[ManagerPermission] [bigint] NOT NULL,
	[OperationPermission] [bigint] NOT NULL,
	[StateFlag] [int] NOT NULL,
 CONSTRAINT [PK_Base_RolePermission] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC,
	[ModuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ɫ��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_RolePermission', @level2type=N'COLUMN',@level2name=N'RoleID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ģ���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_RolePermission', @level2type=N'COLUMN',@level2name=N'ModuleID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����Ȩ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_RolePermission', @level2type=N'COLUMN',@level2name=N'ManagerPermission'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����Ȩ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_RolePermission', @level2type=N'COLUMN',@level2name=N'OperationPermission'
GO

/****** Object:  Table [dbo].[Base_Roles]    Script Date: 2017/7/13 17:56:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Base_Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](128) NOT NULL,
	[Description] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_Base_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ɫ��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Roles', @level2type=N'COLUMN',@level2name=N'RoleID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ɫ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Roles', @level2type=N'COLUMN',@level2name=N'RoleName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ɫ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Roles', @level2type=N'COLUMN',@level2name=N'Description'
GO

/****** Object:  Table [dbo].[Base_Users]    Script Date: 2017/7/13 17:56:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Base_Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[RoleID] [int] NOT NULL,
	[Nullity] [tinyint] NOT NULL,
	[PreLogintime] [datetime] NOT NULL,
	[PreLoginIP] [nvarchar](50) NOT NULL,
	[LastLogintime] [datetime] NOT NULL,
	[LastLoginIP] [nvarchar](50) NOT NULL,
	[LoginTimes] [int] NOT NULL,
	[IsBand] [int] NOT NULL,
	[BandIP] [nvarchar](50) NOT NULL,
	[IsAssist] [tinyint] NOT NULL,
 CONSTRAINT [PK_Base_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Base_Users] ADD  CONSTRAINT [DF_Base_Users_Flag]  DEFAULT ((0)) FOR [Nullity]
GO

ALTER TABLE [dbo].[Base_Users] ADD  CONSTRAINT [DF_Base_Users_PreLogintime]  DEFAULT (getdate()) FOR [PreLogintime]
GO

ALTER TABLE [dbo].[Base_Users] ADD  CONSTRAINT [DF_Base_Users_PreLoginIP]  DEFAULT ('000.000.000.000') FOR [PreLoginIP]
GO

ALTER TABLE [dbo].[Base_Users] ADD  CONSTRAINT [DF_Base_Users_LastLogintime]  DEFAULT (getdate()) FOR [LastLogintime]
GO

ALTER TABLE [dbo].[Base_Users] ADD  CONSTRAINT [DF_Base_Users_LastLoginIP]  DEFAULT ('000.000.000.000') FOR [LastLoginIP]
GO

ALTER TABLE [dbo].[Base_Users] ADD  CONSTRAINT [DF_Base_Users_LoginTimes]  DEFAULT ((0)) FOR [LoginTimes]
GO

ALTER TABLE [dbo].[Base_Users] ADD  CONSTRAINT [DF_Base_Users_IsBand]  DEFAULT ((1)) FOR [IsBand]
GO

ALTER TABLE [dbo].[Base_Users] ADD  CONSTRAINT [DF_Base_Users_BandIP]  DEFAULT ('000.000.000.000') FOR [BandIP]
GO

ALTER TABLE [dbo].[Base_Users] ADD  CONSTRAINT [DF_Base_Users_IsAssist]  DEFAULT ((0)) FOR [IsAssist]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����ԱID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Users', @level2type=N'COLUMN',@level2name=N'UserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�ʺ�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Users', @level2type=N'COLUMN',@level2name=N'Username'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Users', @level2type=N'COLUMN',@level2name=N'Password'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ɫID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Users', @level2type=N'COLUMN',@level2name=N'RoleID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����־ 0-���ã�1-����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Users', @level2type=N'COLUMN',@level2name=N'Nullity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��IP 0-�� 1-δ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Users', @level2type=N'COLUMN',@level2name=N'IsBand'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Ƿ�����Ӫ����Ȩ��(0:��Ȩ��,1:��Ȩ��)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Base_Users', @level2type=N'COLUMN',@level2name=N'IsAssist'
GO

/****** Object:  Table [dbo].[SystemSecurity]    Script Date: 2017/7/13 17:57:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SystemSecurity](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[OperatingTime] [datetime] NOT NULL,
	[OperatingName] [nvarchar](50) NOT NULL,
	[OperatingIP] [nvarchar](50) NOT NULL,
	[OperatingAccounts] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����ʺ�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemSecurity', @level2type=N'COLUMN',@level2name=N'OperatingAccounts'
GO


