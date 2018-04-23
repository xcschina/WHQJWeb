USE WHQJAgentDB
GO

----------------------------------------------------------------------------------------------------
-- ��Ȩ��2018
-- ʱ�䣺2018-04-17
-- ��;����Ұ󶨴��� ���ظ��󶨻���ƹ�ʱ��Ч��
----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PB_UserAgentBind]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PB_UserAgentBind]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

--------------------------------------------------------------------	
--
CREATE PROC [NET_PB_UserAgentBind]
(
	@dwUserID			INT,					--�û���ʶ
	@dwGameID	    INT,			    --Ŀ���������GameID

	@strErrorDescribe NVARCHAR(127) OUTPUT		--�����Ϣ
)

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �û���Ϣ
DECLARE @UserID INT
DECLARE @Nullity TINYINT
DECLARE @SpreaderID INT
DECLARE @AgentID INT
DECLARE @SpreaderAgent INT
DECLARE @OriginSpreaderID INT

BEGIN
	-- ��ѯ�û�	
	SELECT @UserID=UserID,@Nullity=Nullity,@OriginSpreaderID=SpreaderID FROM WHQJAccountsDB.DBO.AccountsInfo WITH(NOLOCK) WHERE UserID=@dwUserID
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

	IF @OriginSpreaderID>0
	BEGIN
	SET @strErrorDescribe=N'��Ǹ�����Ѱ󶨹�ϵ���������°󶨣�'
	RETURN 1003
	END

	SELECT @SpreaderID=UserID,@Nullity=Nullity,@SpreaderAgent = SpreaderID,@AgentID = AgentID FROM WHQJAccountsDB.DBO.AccountsInfo WITH(NOLOCK) WHERE GameID=@dwGameID
  
	IF @SpreaderID IS NULL 
	BEGIN
	SET @strErrorDescribe=N'��Ǹ�����󶨵���Ҳ����ڣ�'
	RETURN 1004
	END

	-- ���Ŀ����ҷǴ��������������ϼ�
	IF @AgentID = 0
	BEGIN
	SET @SpreaderID = @SpreaderAgent
	END

	-- ������Ǵ����򲻰�
	IF @SpreaderID = 0
	BEGIN
	SET @strErrorDescribe=N'��Ǹ�����󶨵���ҷǴ�������ߣ�'
	RETURN 1005
	END

	-- �󶨴����ϵ
	UPDATE WHQJAccountsDB.DBO.AccountsInfo SET SpreaderID = @SpreaderID WHERE UserID = @UserID
	-- �����ϼ���������
	UPDATE AgentInfo SET BelowUser = BelowUser + 1 WHERE UserID = @SpreaderID

	SET @strErrorDescribe = N'��ϲ�����󶨳ɹ���'
	RETURN 0
END
GO