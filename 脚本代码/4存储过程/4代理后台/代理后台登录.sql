----------------------------------------------------------------------------------------------------
-- ��Ȩ��2011
-- ʱ�䣺2011-08-31
-- ��;�������̨��¼��΢�ţ�
----------------------------------------------------------------------------------------------------

USE WHQJAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_AgentAccountsLogin') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_AgentAccountsLogin
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

-- �ʺŵ�¼
CREATE PROCEDURE NET_PW_AgentAccountsLogin
	@strUserUin NVARCHAR(32),					-- ��¼΢�ű�ʶ
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

	-- ��ѯ�û�
	SELECT @UserID=UserID, @GameID=GameID, @Accounts=Accounts, @Nickname=Nickname, @UnderWrite=UnderWrite, @FaceID=FaceID,@CustomID=CustomID,
		@Gender=Gender, @Nullity=Nullity, @StunDown=StunDown, @SpreaderID=SpreaderID,@PlayTimeCount=PlayTimeCount,@AgentID=AgentID
	FROM AccountsInfo WITH(NOLOCK) WHERE UserUin=@strUserUin

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
	SELECT @AgentNullity=Nullity FROM AccountsAgentInfo WITH(NOLOCK) WHERE AgentID=@AgentID
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
  SELECT @AgentID = AgentID,@UserID = UserID,@AgentNullity=Nullity FROM AccountAgentInfo WITH(NOLOCK) WHERE ContactPhone = @strMobile AND [Password] = @strPassword

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
