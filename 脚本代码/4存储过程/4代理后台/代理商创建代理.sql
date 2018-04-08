----------------------------------------------------------------------
-- ʱ�䣺2015-10-10
-- ��;����������Ӵ����û�
----------------------------------------------------------------------
USE WHQJAccountsDB
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_AddAgentUserByAgent]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_AddAgentUserByAgent]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PM_AddAgentUserByAgent]
(
	@dwUserID			INT,					--�û���ʶ
	@dwGameID			INT,					--��Ϸ I D
	@strCompellation	NVARCHAR(16),			--��������
	@strAgentDomain		NVARCHAR(50),			--��������
	@strQQAccount       NVARCHAR(32),			--Q Q �˺�
	@strWCNickName      NVARCHAR(32),			--΢���ǳ�
	@strContactPhone    NVARCHAR(32),			--��ϵ�绰
	@strContactAddress  NVARCHAR(32),			--��ϵ��ַ
	@strAgentNote       NVARCHAR(32),			--����ע

	@strErrorDescribe NVARCHAR(127) OUTPUT		--�����Ϣ
)

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �û���Ϣ
DECLARE @UserID INT
DECLARE @Nullity TINYINT
DECLARE @AgentID INT
DECLARE @AgentLevel TINYINT

DECLARE @NewAgentLevel TINYINT
DECLARE @ParentAgentID INT

DECLARE @NewUserID INT
DECLARE @NewNullity TINYINT
DECLARE @NewAgentID INT

BEGIN
	-- ��ѯ�û�	
	SELECT @UserID=UserID,@Nullity=Nullity,@AgentID=AgentID FROM AccountsInfo WITH(NOLOCK) WHERE UserID=@dwUserID
	SET @ParentAgentID = @AgentID

	-- �û�����
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������ʺŲ����ڣ�'
		RETURN 1001
	END	

	-- �ʺŽ�ֹ
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������ʺ��Ѷ��ᣡ'
		RETURN 1002
	END	

	-- ��ѯ������Ϣ
	SELECT @AgentLevel=AgentLevel FROM AccountsAgentInfo WITH(NOLOCK) WHERE AgentID=@AgentID
	IF @AgentLevel IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������˺�Ϊ�Ǵ����̣�'
		RETURN 1003
	END
	IF @AgentLevel=3
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������������޷�����¼�����'
		RETURN 1004
	END
	-- ���ô�����
	SET @NewAgentLevel= @AgentLevel + 1

	-- ��ѯ���������ظ���Ϣ
	IF EXISTS(SELECT AgentID FROM AccountsAgentInfo WITH(NOLOCK) WHERE AgentDomain=@strAgentDomain)
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�����������Ѵ��ڣ�'
		RETURN 2001
	END

	-- ��ӵĴ����˺���֤
	SELECT @NewUserID=UserID,@NewNullity=Nullity,@NewAgentID=AgentID FROM AccountsInfo WITH(NOLOCK) WHERE GameID=@dwGameID
	IF @NewUserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ������Ϊ������˺Ų����ڣ�'
		RETURN 2002
	END	
	-- �ʺŽ�ֹ
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ������Ϊ������˺��Ѷ��ᣡ'
		RETURN 2003
	END	
	IF @NewAgentID>0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ������Ϊ������˺��Ѿ��Ǵ����̣�'
		RETURN 2004
	END

	-- ������Ϣ
	INSERT INTO AccountsAgentInfo(ParentAgent,UserID,Compellation,QQAccount,WCNickName,ContactPhone,ContactAddress,AgentDomain,AgentLevel,AgentNote,Nullity,CollectDate)
	VALUES(@ParentAgentID,@NewUserID,@strCompellation,@strQQAccount,@strWCNickName,@strContactPhone,@strContactAddress,@strAgentDomain,@NewAgentLevel,@strAgentNote,0,getdate())
	SELECT @NewAgentID = SCOPE_IDENTITY()

	-- �����û�
	IF @@ERROR=0 
	BEGIN
		UPDATE AccountsInfo SET AgentID=@NewAgentID WHERE UserID = @NewUserID
		SET @strErrorDescribe=N'��ϲ�����������ɹ���'
		RETURN 0
	END
	ELSE
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��������ʧ�ܡ�'
		RETURN 2005
	END
END
GO