USE [WHQJAccountsDB]
GO

-- V1.1.0
DELETE DBO.SystemStatusInfo WHERE StatusName = N'IOSNotStorePaySwitch'
DELETE DBO.SystemStatusInfo WHERE StatusName = N'JJGoldBuyProp'
-- V1.1.4 2017/12/26 ɾ��ȫ��ϵͳ���õ���ʯ�������������
DELETE DBO.SystemStatusInfo WHERE StatusName = N'JJDiamondBuyProp'

-- V1.1.0 2017/11/16 ���ȫ���ƹ㷵������ 0����� 1����ʯ
-- INSERT INTO SystemStatusInfo
--   (StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID)
-- VALUES(N'SpreadReturnType', 0, N'ȫ���ƹ㷵������', N'�ƹ㷵������', N'��ֵ���ƹ㷵�����ͣ����ƹ㷵�������޿�������ʱ����Ч��0��ʾ��� 1��ʾ��ʯ', 99)
-- V1.1.0 2017/11/23 ���ȫ���ƹ㷵����ȡ�ż� 0�����ż� ����0���� ��Ҫ����ȡ�����ڶ��ٲ�����ȡ
-- INSERT INTO SystemStatusInfo
--   (StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID)
-- VALUES(N'SpreadReceiveBase', 0, N'ȫ���ƹ㷵����ȡ�ż�', N'�ƹ㷵������', N'��ֵ���ƹ㷵��������0�����ż� ����0���� ��Ҫ����ȡ�����ڶ��ٲ�����ȡ', 100)

-- V1.1.3 2017/12/13 �û������λ����Ϣ ��ȷ���°汾����
-- ALTER TABLE [dbo].[AccountsInfo] ADD [PlaceName] NVARCHAR(33) NOT NULL DEFAULT(N'')
-- GO
-- EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���һ�ε�¼����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'PlaceName'
-- GO

USE [WHQJNativeWebDB]
GO

-- V1.1.0
DELETE DBO.ConfigInfo WHERE ConfigKey = N'GameAndroidConfig'
DELETE DBO.ConfigInfo WHERE ConfigKey = N'GameIosConfig'

-- V1.1.6 ��Ϸ���� ���������ֶΡ�
ALTER TABLE [dbo].[GameRule] ADD [SortID] INT NOT NULL DEFAULT(0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�淨����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameRule', @level2type=N'COLUMN',@level2name=N'SortID'
GO


-- V1.1.4�ݲ����´��޸� ���߹���Ǩ��
-- ALTER TABLE [dbo].[RecordBuyNewProperty] ADD [BeforeScore] BIGINT NOT NULL DEFAULT(0)
-- GO
-- EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����ǰЯ�����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'BeforeInsure'
-- GO
-- ALTER TABLE [dbo].[RecordBuyNewProperty] ADD [Score] INT NOT NULL DEFAULT(0)
-- GO
-- EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���򻨷�Я�����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'Insure'
-- GO


USE [WHQJPlatformManagerDB]
GO

-- V1.1.4 ���߹���Ǩ��
DELETE DBO.Base_Module WHERE ModuleID = 306
INSERT DBO.Base_Module (ModuleID,ParentID,Title,Link,OrderNo,Nullity,IsMenu,[Description],ManagerPopedom)
VALUES (306,3,N'���߹���',N'/Module/AppManager/PropertyConfigList.aspx',7,0,0,N'',0)
GO
INSERT INTO [dbo].[Base_ModulePermission] ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (306,N'�鿴',1,0,0,1)
GO
INSERT INTO [dbo].[Base_ModulePermission] ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (306,N'�༭',2,0,0,1)
GO

-- V1.1.6 ��̨�޸�����Ȩ���޲鿴������ҵ����⡣
INSERT DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (101,N'�鿴',1,0,0,1)
GO

USE [WHQJPlatformDB]
GO

-- V1.1.4�ݲ����´��޸� ���߹���Ǩ��
-- EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'ExchangeRatio'
-- GO
-- ALTER TABLE [dbo].[GameProperty] DROP CONSTRAINT [DF_GameProperty_ExchangeRatio]
-- ALTER TABLE [dbo].[GameProperty] DROP CONSTRAINT [DF_GameProperty_Diamond]
-- GO
-- ALTER TABLE [dbo].[GameProperty] DROP COLUMN [ExchangeRatio]
-- GO
-- ALTER TABLE [dbo].[GameProperty] ADD [ExchangeDiamondRatio] INT NOT NULL DEFAULT(0)
-- GO
-- EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ʯ�һ����߱���1��ʯ:N' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'ExchangeDiamondRatio'
-- GO
-- ALTER TABLE [dbo].[GameProperty] ADD [ExchangeGoldRatio] INT NOT NULL DEFAULT(0)
-- GO
-- EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��Ҷһ����߱���N���:1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameProperty', @level2type=N'COLUMN',@level2name=N'ExchangeGoldRatio'
-- GO
-- UPDATE [dbo].[GameProperty] SET ExchangeDiamondRatio = 10 WHERE ID = 306 --���������¸�ֵ
-- GO

USE [WHQJNativeWebDB]
GO

-- V1.1.7 ��Ϸ���� ����ֶ��޸�
ALTER TABLE [dbo].[GameRule] DROP CONSTRAINT [DF_GameRule_KindIntro]
ALTER TABLE [dbo].[GameRule] ALTER COLUMN [KindIntro] NVARCHAR(MAX) NOT NULL
ALTER TABLE [dbo].[GameRule] ADD CONSTRAINT [DF_GameRule_KindIntro] DEFAULT (N'') FOR [KindIntro]
GO

-- V1.1.7 ���������������
 -- ����
IF EXISTS (SELECT 1
FROM [DBO].SYSObjects
WHERE ID = OBJECT_ID(N'[dbo].[Question]') AND OBJECTPROPERTY(ID,'IsTable')=1 )
BEGIN
  DROP TABLE [dbo].[Question]
END

/****** Object:  Table [dbo].[Question]    Script Date: 2018/1/25 10:57:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[QuestionTitle] [nvarchar](128) NOT NULL CONSTRAINT [DF_Question_QuestionTitle]  DEFAULT (N''),
	[Answer] [nvarchar](256) NOT NULL CONSTRAINT [DF_Question_Answer]  DEFAULT (N''),
	[SortID] [int] NOT NULL CONSTRAINT [DF_Question_SortID]  DEFAULT ((0)),
	[UpdateAt] [datetime] NOT NULL CONSTRAINT [DF_Question_UpdateAt]  DEFAULT (getdate()),
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED
(
	[ID] ASC,
	[QuestionTitle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�ʴ��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'QuestionTitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'Answer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'UpdateAt'
GO

 -- ����Ĭ������
SET IDENTITY_INSERT [dbo].[Question] ON
INSERT [dbo].[Question] ([ID], [QuestionTitle], [Answer], [SortID]) VALUES (1, N'��λ�ȡ������', N'����ϵ�ͷ���12345678', 1)
INSERT [dbo].[Question] ([ID], [QuestionTitle], [Answer], [SortID]) VALUES (2, N'��λ�ȡ��ʯ��', N'����ϵ�ͷ���12345678', 2)
INSERT [dbo].[Question] ([ID], [QuestionTitle], [Answer], [SortID]) VALUES (3, N'�����ϵ�ͷ���', N'����ϵ�ͷ���12345678', 3)
INSERT [dbo].[Question] ([ID], [QuestionTitle], [Answer], [SortID]) VALUES (4, N'��λ�ȡ��Ϸ�ң�', N'����ϵ�ͷ���12345678', 4)
SET IDENTITY_INSERT [dbo].[Question] OFF


USE [WHQJPlatformManagerDB]
GO
-- V1.1.7 ��̨���������������ģ��
  -- �����µ�ģ��
DELETE DBO.Base_Module WHERE ModuleID = 405
INSERT DBO.Base_Module (ModuleID,ParentID,Title,Link,OrderNo,Nullity,IsMenu,[Description],ManagerPopedom)
VALUES (405,3,N'��������',N'/Module/WebManager/QuestionList.aspx',9,0,0,N'',0)
GO
  -- ������ģ���Ȩ��
DELETE DBO.Base_ModulePermission WHERE ModuleID = 405
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (405,N'�鿴',1,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (405,N'����',2,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (405,N'�޸�',4,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (405,N'ɾ��',8,0,0,1)
GO


USE [WHQJNativeWebDB]
GO

-- v1.1.10 �½�������֤��Ϣ��
IF EXISTS (SELECT 1
FROM [DBO].SYSObjects
WHERE ID = OBJECT_ID(N'[dbo].[AgentTokenInfo]') AND OBJECTPROPERTY(ID,'IsTable')=1 )
BEGIN
  DROP TABLE [dbo].[AgentTokenInfo]
END
GO

/****** Object:  Table [dbo].[AgentTokenInfo]    Script Date: 2018/3/16 16:32:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AgentTokenInfo](
	[UserID] [int] NOT NULL,
	[AgentID] [int] NOT NULL,
	[Token] [nvarchar](64) NOT NULL,
	[ExpirtAt] [datetime] NOT NULL,
 CONSTRAINT [PK_AgentTokenInfo] PRIMARY KEY CLUSTERED
(
	[UserID] ASC,
	[AgentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[AgentTokenInfo] ADD  CONSTRAINT [DF_AgentTokenInfo_UserID]  DEFAULT ((0)) FOR [UserID]
GO

ALTER TABLE [dbo].[AgentTokenInfo] ADD  CONSTRAINT [DF_AgentTokenInfo_AgentID]  DEFAULT ((0)) FOR [AgentID]
GO

ALTER TABLE [dbo].[AgentTokenInfo] ADD  CONSTRAINT [DF_AgentTokenInfo_Token]  DEFAULT (N'') FOR [Token]
GO

ALTER TABLE [dbo].[AgentTokenInfo] ADD  CONSTRAINT [DF_AgentTokenInfo_ExpirtAt]  DEFAULT (getdate()+(1)) FOR [ExpirtAt]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgentTokenInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�����ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgentTokenInfo', @level2type=N'COLUMN',@level2name=N'AgentID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��֤����SHA256��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgentTokenInfo', @level2type=N'COLUMN',@level2name=N'Token'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AgentTokenInfo', @level2type=N'COLUMN',@level2name=N'ExpirtAt'
GO


-- v1.1.10 �����̨��¼���ֻ���+��ȫ���룩�洢
----------------------------------------------------------------------------------------------------
-- ��Ȩ��2018
-- ʱ�䣺2018-03-16
-- ��;�������̨��¼���ֻ���+��ȫ���룩
----------------------------------------------------------------------------------------------------

USE WHQJAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_AgentAccountsLogin_MP') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_AgentAccountsLogin_MP
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

-- �ʺŵ�¼
CREATE PROCEDURE NET_PW_AgentAccountsLogin_MP
	@strMobile NVARCHAR(11),					-- �ֻ�����
	@strPassword NVARCHAR(32),					-- ��ȫ����
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strErrorDescribe	NVARCHAR(127) OUTPUT	-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ������Ϣ
DECLARE @UserID INT
DECLARE @FaceID INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @Nickname NVARCHAR(31)
DECLARE @UnderWrite NVARCHAR(63)
DECLARE @AgentID INT
DECLARE @Nullity BIT
DECLARE @StunDown BIT

-- ��չ��Ϣ
DECLARE @GameID INT
DECLARE @CustomID INT
DECLARE @Gender TINYINT
DECLARE @Experience INT
DECLARE @Loveliness INT
DECLARE @MemberOrder INT
DECLARE @MemberOverDate DATETIME
DECLARE @CustomFaceVer TINYINT
DECLARE @SpreaderID INT
DECLARE @PlayTimeCount INT
DECLARE @AgentNullity TINYINT

-- ��������
DECLARE @EnjoinLogon AS INT
DECLARE @StatusString NVARCHAR(127)

-- ִ���߼�
BEGIN
	-- ϵͳ��ͣ
	SELECT @EnjoinLogon=StatusValue,@StatusString=StatusString FROM SystemStatusInfo WITH(NOLOCK) WHERE StatusName=N'EnjoinLogon'
	IF @EnjoinLogon=1
	BEGIN
		SELECT @strErrorDescribe=@StatusString
		RETURN 1001
	END

	-- Ч���ַ
	SELECT @EnjoinLogon=EnjoinLogon FROM ConfineAddress WITH(NOLOCK) WHERE AddrString=@strClientIP AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinLogon=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��ϵͳ��ֹ�������ڵ� IP ��ַ�ĵ�¼���ܣ�'
		RETURN 1002
	END

  -- ��ѯ����
  SELECT @AgentID = AgentID,@UserID = UserID,@AgentNullity=Nullity FROM AccountsAgentInfo WITH(NOLOCK) WHERE ContactPhone = @strMobile AND [Password] = @strPassword

  IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������ʺŲ����ڣ�'
		RETURN 1002
	END

	-- ��ѯ�û�
	SELECT @GameID=GameID, @Accounts=Accounts, @Nickname=Nickname, @UnderWrite=UnderWrite, @FaceID=FaceID,@CustomID=CustomID,
		@Gender=Gender, @Nullity=Nullity, @StunDown=StunDown, @SpreaderID=SpreaderID,@PlayTimeCount=PlayTimeCount,@AgentID=AgentID
	FROM AccountsInfo WITH(NOLOCK) WHERE UserID=@UserID

	-- �ʺŽ�ֹ
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������ʺ��Ѷ��ᣡ'
		RETURN 1003
	END

	-- �ʺŹر�
	IF @StunDown=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������ʺ��ѿ�����ȫ�رգ�'
		RETURN 1004
	END

  -- �����ж�
	IF @AgentID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������ʺ�Ϊ�Ǵ����̣�'
		RETURN 2001
	END
	IF @AgentNullity IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������ʺ�Ϊ�Ǵ����̣�'
		RETURN 2001
	END
	IF @AgentNullity=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�����Ĵ����ʺ��Ѷ��ᣡ'
		RETURN 2002
	END

	-- ������Ϣ
	UPDATE AccountsInfo SET WebLogonTimes=WebLogonTimes+1,LastLogonDate=GETDATE(),LastLogonIP=@strClientIP WHERE UserID=@UserID

	-- ��¼��־
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	UPDATE SystemStreamInfo SET WebLogonSuccess=WebLogonSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT SystemStreamInfo (DateID, WebLogonSuccess) VALUES (@DateID, 1)

	-- �������
	SELECT @UserID AS UserID, @GameID AS GameID, @Accounts AS Accounts, @Nickname AS Nickname,@UnderWrite AS UnderWrite, @FaceID AS FaceID, @CustomID AS CustomID,
		@Gender AS Gender,@AgentID AS AgentID
END

RETURN 0
GO


-- 1.1.10 ��������ֵ���������İ汾
USE WHQJAccountsDB
GO

INSERT DBO.SystemStatusInfo (StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID)
VALUES (N'AgentHomeVersion',1, N'�����̨�İ汾�ţ����л����Ϻ�̨',N'�����̨�汾',N'��ֵ��1-�ϰ汾������̨��2-�°汾������̨',9999)
GO
