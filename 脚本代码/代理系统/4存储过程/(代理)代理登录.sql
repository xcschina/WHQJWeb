USE WHQJAgentDB
GO

----------------------------------------------------------------------------------------------------
-- ��Ȩ��2018
-- ʱ�䣺2018-04-17
-- ��;�������̨��¼��΢�ţ�
----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_AT_AgentLogin_WX') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_AT_AgentLogin_WX
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

-- �ʺŵ�¼
CREATE PROCEDURE NET_AT_AgentLogin_WX
	@strUserUin NVARCHAR(32),					-- ��¼΢�ű�ʶ
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strErrorDescribe	NVARCHAR(127) OUTPUT	-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ������Ϣ
DECLARE @UserID INT
DECLARE @AgentID INT
DECLARE @Nullity BIT
DECLARE @StunDown BIT

-- ��չ��Ϣ
DECLARE @AgentNullity TINYINT

-- ��������
DECLARE @EnjoinLogon AS INT
DECLARE @StatusString NVARCHAR(127)

-- ִ���߼�
BEGIN
	-- ϵͳ��ͣ
	SELECT @EnjoinLogon=StatusValue,@StatusString=StatusString FROM WHQJAccountsDB.DBO.SystemStatusInfo WITH(NOLOCK) WHERE StatusName=N'EnjoinLogon'
	IF @EnjoinLogon=1
	BEGIN
		SELECT @strErrorDescribe=@StatusString
		RETURN 1001
	END

	-- Ч���ַ
	SELECT @EnjoinLogon=EnjoinLogon FROM WHQJAccountsDB.DBO.ConfineAddress WITH(NOLOCK) WHERE AddrString=@strClientIP AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinLogon=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��ϵͳ��ֹ�������ڵ� IP ��ַ�ĵ�¼���ܣ�'
		RETURN 1002
	END

	-- ��ѯ�û�
	SELECT @UserID=UserID, @AgentID=AgentID, @Nullity=Nullity, @StunDown=StunDown,@AgentID=AgentID
	FROM WHQJAccountsDB.DBO.AccountsInfo WITH(NOLOCK) WHERE UserUin=@strUserUin

	-- ��ѯ�û�
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������ʺŲ����ڣ�'
		RETURN 1002
	END

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
	IF @AgentID=0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������ʺ�Ϊ�Ǵ����̣�'
		RETURN 2001
	END
	-- ��ȡ������Ϣ
	SELECT @AgentNullity=Nullity FROM AgentInfo WITH(NOLOCK) WHERE AgentID=@AgentID
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
	UPDATE WHQJAccountsDB.DBO.AccountsInfo SET WebLogonTimes=WebLogonTimes+1,LastLogonDate=GETDATE(),LastLogonIP=@strClientIP WHERE UserID=@UserID

	-- ��¼��־
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	UPDATE WHQJAccountsDB.DBO.SystemStreamInfo SET WebLogonSuccess=WebLogonSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT WHQJAccountsDB.DBO.SystemStreamInfo (DateID, WebLogonSuccess) VALUES (@DateID, 1)

	-- �������
	SELECT * FROM AgentInfo WITH(NOLOCK) WHERE AgentID=@AgentID
END

RETURN 0
GO


----------------------------------------------------------------------------------------------------
-- ��Ȩ��2018
-- ʱ�䣺2018-04-17
-- ��;�������̨��¼���ֻ���+��ȫ���룩
----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_AT_AgentLogin_MP') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_AT_AgentLogin_MP
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

-- �ʺŵ�¼
CREATE PROCEDURE NET_AT_AgentLogin_MP
	@strMobile NVARCHAR(11),					-- �ֻ�����
	@strPassword NVARCHAR(32),					-- ��ȫ����
	@strClientIP NVARCHAR(15),					-- ���ӵ�ַ
	@strErrorDescribe	NVARCHAR(127) OUTPUT	-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ������Ϣ
DECLARE @UserID INT
DECLARE @AgentID INT
DECLARE @Nullity BIT
DECLARE @StunDown BIT

-- ��չ��Ϣ
DECLARE @AgentNullity TINYINT

-- ��������
DECLARE @EnjoinLogon AS INT
DECLARE @StatusString NVARCHAR(127)

-- ִ���߼�
BEGIN
	-- ϵͳ��ͣ
	SELECT @EnjoinLogon=StatusValue,@StatusString=StatusString FROM WHQJAccountsDB.DBO.SystemStatusInfo WITH(NOLOCK) WHERE StatusName=N'EnjoinLogon'
	IF @EnjoinLogon=1
	BEGIN
		SELECT @strErrorDescribe=@StatusString
		RETURN 1001
	END

	-- Ч���ַ
	SELECT @EnjoinLogon=EnjoinLogon FROM WHQJAccountsDB.DBO.ConfineAddress WITH(NOLOCK) WHERE AddrString=@strClientIP AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinLogon=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��ϵͳ��ֹ�������ڵ� IP ��ַ�ĵ�¼���ܣ�'
		RETURN 1002
	END

  -- ��ѯ����
  SELECT @AgentID = AgentID,@UserID = UserID,@AgentNullity=Nullity FROM AgentInfo WITH(NOLOCK) WHERE ContactPhone = @strMobile AND [Password] = @strPassword

  IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������ʺŲ����ڣ�'
		RETURN 1002
	END

	-- ��ѯ�û�
	SELECT @Nullity=Nullity, @StunDown=StunDown,@AgentID=AgentID
	FROM WHQJAccountsDB.DBO.AccountsInfo WITH(NOLOCK) WHERE UserID=@UserID

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
	UPDATE WHQJAccountsDB.DBO.AccountsInfo SET WebLogonTimes=WebLogonTimes+1,LastLogonDate=GETDATE(),LastLogonIP=@strClientIP WHERE UserID=@UserID

	-- ��¼��־
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	UPDATE WHQJAccountsDB.DBO.SystemStreamInfo SET WebLogonSuccess=WebLogonSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT WHQJAccountsDB.DBO.SystemStreamInfo (DateID, WebLogonSuccess) VALUES (@DateID, 1)

	-- �������
	SELECT * FROM AgentInfo WITH(NOLOCK) WHERE AgentID=@AgentID
END

RETURN 0
GO
