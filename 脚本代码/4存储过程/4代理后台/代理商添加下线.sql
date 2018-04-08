----------------------------------------------------------------------
-- ʱ�䣺2015-10-10
-- ��;���������������
----------------------------------------------------------------------
USE WHQJAccountsDB
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_AddAgentSpreadUser]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_AddAgentSpreadUser]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PM_AddAgentSpreadUser]
(
	@dwUserID			INT,					--�û���ʶ
	@dwGameID			INT,					--��ϷID

	@strErrorDescribe NVARCHAR(127) OUTPUT		--�����Ϣ
)

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �û���Ϣ
DECLARE @UserID INT
DECLARE @Nullity TINYINT
DECLARE @AgentID INT
DECLARE @AgentNullity TINYINT

DECLARE @SpreaderID INT
DECLARE @UAgentID INT
DECLARE @UserIDStr NVARCHAR(2000)

BEGIN
	-- ��ѯ�û�	
	SELECT @UserID=UserID,@Nullity=Nullity,@AgentID=AgentID FROM AccountsInfo WITH(NOLOCK) WHERE UserID=@dwUserID
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
	IF @AgentID<=0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������˺�Ϊ�Ǵ����̣�'
		RETURN 1003
	END

	-- ��ѯ������Ϣ
	SELECT @AgentNullity=Nullity FROM AccountsAgentInfo WITH(NOLOCK) WHERE AgentID=@AgentID
	IF @AgentNullity IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������˺�Ϊ�Ǵ����̣�'
		RETURN 1003
	END
	IF @AgentNullity=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�����Ĵ����˺��Ѷ��ᣡ'
		RETURN 1004
	END
	
	-- ��ѯ�����û�
	SET @UserIDStr = ''
	SELECT @SpreaderID=SpreaderID,@UAgentID=AgentID FROM AccountsInfo WITH(NOLOCK) WHERE GameID=@dwGameID
	IF @UAgentID>0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ������ӵ������Ѱ󶨴����̣�'
		RETURN 1005
	END
	WHILE @SpreaderID>0
	BEGIN
		SET @UserIDStr = @UserIDStr + CAST(@SpreaderID AS NVARCHAR(10)) + ','
		SELECT @SpreaderID=SpreaderID,@UAgentID=AgentID FROM AccountsInfo WITH(NOLOCK) WHERE UserID = @SpreaderID
		IF @UAgentID>0
		BEGIN
			SET @SpreaderID = 0
			SET @strErrorDescribe=N'��Ǹ������ӵ������Ѱ󶨴����̣�'
			RETURN 1005
		END
		IF CHARINDEX(CAST(@SpreaderID AS NVARCHAR(10)),@UserIDStr)>0
		BEGIN
			SET @SpreaderID = 0
		END
	END

	-- ������
	UPDATE AccountsInfo SET SpreaderID=@UserID WHERE GameID=@dwGameID
	IF @@ROWCOUNT>0
	BEGIN
		SET @strErrorDescribe=N'��ϲ�������߰󶨳ɹ���'
		RETURN 0
	END
	ELSE
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�����߰�ʧ�ܣ�'
		RETURN 2005
	END
END
GO