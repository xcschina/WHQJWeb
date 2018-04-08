----------------------------------------------------------------------
-- ʱ�䣺2015-10-10
-- ��;����̨����Ա��Ӵ����û�
----------------------------------------------------------------------
USE WHQJAccountsDB
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_AddAgentUser]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_AddAgentUser]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PM_AddAgentUser]
(
	@dwUserID			INT,					--�û���ʶ
	@strCompellation	NVARCHAR(16),			--��������
	@strAgentDomain		NVARCHAR(50),			--��������
	@strQQAccount       NVARCHAR(32),			--Q Q �˺�
	@strWCNickName      NVARCHAR(32),			--΢���ǳ�
	@strContactPhone    NVARCHAR(32),			--��ϵ�绰
	@strContactAddress  NVARCHAR(32),			--��ϵ��ַ
	@dwAgentLevel       NVARCHAR(32),			--����ȼ�
	@strAgentNote       NVARCHAR(32),			--����ע
	@dwParentGameID		INT,					--��������

	@strErrorDescribe NVARCHAR(127) OUTPUT		--�����Ϣ
)

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �û���Ϣ
DECLARE @UserID INT
DECLARE @Nullity TINYINT
DECLARE @AgentID INT
DECLARE @ParentAgentID INT
DECLARE @PParentAgentID INT
DECLARE @NewAgentID INT

BEGIN
	-- ��ѯ�û�	
	SELECT @UserID=UserID,@Nullity=Nullity FROM AccountsInfo WITH(NOLOCK) WHERE UserID=@dwUserID

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

	-- ��ѯ�����ظ���Ϣ
	IF EXISTS(SELECT AgentID FROM AccountsAgentInfo WITH(NOLOCK) WHERE UserID=@dwUserID)
	BEGIN
		SET @strErrorDescribe=N'��Ǹ������˺����Ǵ����˺ţ�'
		RETURN 1003
	END

	-- ��ѯ���������ظ���Ϣ
	IF EXISTS(SELECT AgentID FROM AccountsAgentInfo WITH(NOLOCK) WHERE AgentDomain=@strAgentDomain)
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�����������Ѵ��ڣ�'
		RETURN 1004
	END

	SET @AgentID = 0
	IF @dwAgentLevel<1 AND @dwAgentLevel>3
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ʱֻ֧����������'
		RETURN 1005
	END
	IF @dwAgentLevel=1
	BEGIN
		IF @dwParentGameID>0
		BEGIN
			SET @strErrorDescribe=N'��Ǹ��һ�������޷�������ߣ�'
			RETURN 1006
		END
	END
	IF @dwAgentLevel=2
	BEGIN
		IF @dwParentGameID=0
		BEGIN
			SET @strErrorDescribe=N'��Ǹ������������ָ����һ������'
			RETURN 1007
		END
		SELECT @AgentID=AgentID FROM AccountsInfo WITH(NOLOCK) WHERE GameID=@dwParentGameID
		IF @AgentID <=0
		BEGIN
			SET @strErrorDescribe=N'��Ǹ��ָ���˺�Ϊ�Ǵ���'
			RETURN 1008
		END
		SELECT @ParentAgentID=ParentAgent FROM AccountsAgentInfo WITH(NOLOCK) WHERE AgentID=@AgentID
		IF @ParentAgentID!=0
		BEGIN
			SET @strErrorDescribe=N'��Ǹ������������ָ��һ������'
			RETURN 1009
		END
	END
	IF @dwAgentLevel=3
	BEGIN
		IF @dwParentGameID=0
		BEGIN
			SET @strErrorDescribe=N'��Ǹ������������ָ����������'
			RETURN 2001
		END
		SELECT @AgentID=AgentID FROM AccountsInfo WITH(NOLOCK) WHERE GameID=@dwParentGameID
		IF @AgentID <=0
		BEGIN
			SET @strErrorDescribe=N'��Ǹ��ָ���˺�Ϊ�Ǵ���'
			RETURN 2002
		END
		SELECT @ParentAgentID=ParentAgent FROM AccountsAgentInfo WITH(NOLOCK) WHERE AgentID=@AgentID
		IF @ParentAgentID=0
		BEGIN
			SET @strErrorDescribe=N'��Ǹ������������ָ����������'
			RETURN 2003
		END
		SELECT @PParentAgentID=ParentAgent FROM AccountsAgentInfo WITH(NOLOCK) WHERE AgentID=@ParentAgentID
		IF @PParentAgentID!=0
		BEGIN
			SET @strErrorDescribe=N'��Ǹ������������ָ����������'
			RETURN 2004
		END
	END

	-- ������Ϣ
	INSERT INTO AccountsAgentInfo(ParentAgent,UserID,Compellation,QQAccount,WCNickName,ContactPhone,ContactAddress,AgentDomain,AgentLevel,AgentNote,Nullity,CollectDate)
	VALUES(@AgentID,@dwUserID,@strCompellation,@strQQAccount,@strWCNickName,@strContactPhone,@strContactAddress,@strAgentDomain,@dwAgentLevel,@strAgentNote,0,getdate())
	
	SELECT @NewAgentID = SCOPE_IDENTITY()

	-- �����û�
	IF @@ERROR=0 
	BEGIN
		UPDATE AccountsInfo SET AgentID=@NewAgentID WHERE UserID = @dwUserID
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