----------------------------------------------------------------------------------------------------
-- ��Ȩ��2017
-- ʱ�䣺2017-01-20
-- ��;���ʺ�ע��
----------------------------------------------------------------------------------------------------

USE WHQJAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_RegisterAccountsWX') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_RegisterAccountsWX
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

-- �ʺ�ע��
CREATE PROCEDURE NET_PW_RegisterAccountsWX
	@strUserUin			NVARCHAR(32),			    -- �û�Uin
	@strNickName		NVARCHAR(31),				-- �û��ǳ�
	@cbGender			TINYINT,					-- �û��Ա�
	@strFaceUrl			NVARCHAR(250),				-- ΢��ͷ��
	@strSpreader		NVARCHAR(31),				-- �ƹ�Ա��
	@strClientIP		NVARCHAR(15),				-- ���ӵ�ַ
	@dwRegisterOrigin   TINYINT,					-- ע������
	@strErrorDescribe	NVARCHAR(127) OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ������Ϣ
DECLARE @UserID INT
DECLARE @FaceID INT
DECLARE @CustomID INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @Nickname NVARCHAR(31)
DECLARE @UnderWrite NVARCHAR(63)

-- ��չ��Ϣ
DECLARE @GameID INT
DECLARE @SpreaderID INT
DECLARE @SpreaderGameID 	INT
DECLARE @AgentID INT
DECLARE @Nullity TINYINT
DECLARE @Gender TINYINT
DECLARE @Experience INT
DECLARE @Loveliness INT
DECLARE @MemberOrder INT
DECLARE @MemberOverDate DATETIME
DECLARE @CustomFaceVer TINYINT
DECLARE @Compellation NVARCHAR(16)
DECLARE @PassPortID NVARCHAR(18)

-- ��������
DECLARE @EnjoinLogon INT
DECLARE @EnjoinRegister INT
DECLARE @EnjoinLogonState BIT
DECLARE @EnjoinRegisterState BIT
DECLARE @StatusString NVARCHAR(200)
DECLARE @DateTime DATETIME

-- ִ���߼�
BEGIN
	SET @DateTime = GETDATE()
	-- ע����ͣ
	SELECT @EnjoinRegister=StatusValue,@StatusString=StatusString FROM SystemStatusInfo WITH(NOLOCK) WHERE StatusName=N'EnjoinRegister'
	IF @EnjoinRegister=1
	BEGIN
		SET @strErrorDescribe = @StatusString
		RETURN 1001
	END

	-- ��¼��ͣ
	SELECT @EnjoinLogon=StatusValue,@StatusString=StatusString FROM SystemStatusInfo WITH(NOLOCK) WHERE StatusName=N'EnjoinLogon'
	IF @EnjoinLogon=1
	BEGIN
		SET @strErrorDescribe = @StatusString
		RETURN 1002
	END

	-- Ч���ַ
	SELECT @EnjoinLogonState=EnjoinLogon,@EnjoinRegisterState=EnjoinRegister FROM ConfineAddress WITH(NOLOCK) WHERE AddrString=@strClientIP AND (EnjoinOverDate>@DateTime OR EnjoinOverDate IS NULL)
	IF @EnjoinRegisterState=1 OR @EnjoinLogonState=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��ϵͳ��ֹ�������ڵ� IP ��ַ���ܣ�'
		RETURN 1003
	END

	-- ���ƹ�Ա
	IF @strSpreader<>''
	BEGIN
		-- ���ƹ�Ա
		SELECT @SpreaderID=UserID,@SpreaderGameID=GameID,@AgentID=AgentID FROM AccountsInfo WITH(NOLOCK) WHERE GameID=@strSpreader

		-- �������
		IF @SpreaderID IS NULL OR @SpreaderID=0
		BEGIN
			SET @strErrorDescribe=N'��Ǹ,�ƹ���ID��д����'
			RETURN 2001
		END
	END
	ELSE
	BEGIN
		SET @SpreaderID=0
		SET @AgentID=0
	END

	-- ��ѯ�û�
	IF EXISTS(SELECT UserID FROM AccountsInfo WITH(NOLOCK) WHERE UserUin=@strUserUin)
	BEGIN
		SET @strErrorDescribe=N'��Ǹ,��ͬ�˺���ע��,����������˺ţ�'
		RETURN 2002
	END

	-- ע���û�
	-- �����˺�
	DECLARE @strTemp NVARCHAR(31)
	SET @strTemp=CONVERT(NVARCHAR(31),REPLACE(NEWID(),'-','_'))
	-- ��ѯ�˺�
	IF EXISTS (SELECT UserID FROM AccountsInfo WITH(NOLOCK) WHERE Accounts=@strTemp)
	BEGIN
		SET @strErrorDescribe=N'��Ǹ,ע�ᷱæ,���Ժ����ԣ�'
		RETURN 2004
	END

	-- ע���û�
	INSERT AccountsInfo (Accounts,NickName,RegAccounts,UserUin,LogonPass,InsurePass,Gender,FaceID,WebLogonTimes,RegisterIP,LastLogonIP,RegisterOrigin,PlatformID)
	VALUES (@strTemp,@strNickName,@strTemp,@strUserUin,N'd1fd5495e7b727081497cfce780b6456',N'',@cbGender,0,0,@strClientIP,@strClientIP,@dwRegisterOrigin,5)
	IF @@ROWCOUNT<=0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��ע��ʧ�ܣ����Ժ����ԣ�'
		RETURN 2005
	END

	-- ��ѯ�û�
	SELECT @UserID=UserID, @Accounts=Accounts, @Nickname=Nickname,@UnderWrite=UnderWrite, @Gender=Gender, @Compellation=Compellation,@PassPortID=PassPortID
	FROM AccountsInfo WITH(NOLOCK) WHERE UserUin=@strUserUin

	-- д��ͷ��
	INSERT INTO AccountsFace(UserID,InsertTime,InsertAddr,InsertMachine,FaceUrl) VALUES(@UserID,@DateTime,@strClientIP,'',@strFaceUrl)
	SELECT @CustomID = SCOPE_IDENTITY()

	-- �����ʶ
	SELECT @GameID=GameID FROM GameIdentifier WITH(NOLOCK) WHERE UserID=@UserID
	IF @GameID IS NULL
	BEGIN
		UPDATE AccountsInfo SET CustomID = @CustomID WHERE UserID=@UserID
		SET @GameID=0
		SET @strErrorDescribe=N'ע��ɹ�������ϵ����Ա����ID ��'
	END
	ELSE
	BEGIN
		UPDATE AccountsInfo SET GameID=@GameID,CustomID = @CustomID WHERE UserID=@UserID
	END

	-- ��ʼ�������Ϣ
	INSERT INTO WHQJTreasureDBLink.WHQJTreasureDB.dbo.GameScoreInfo(UserID,RegisterIP) VALUES(@UserID,@strClientIP)
	INSERT INTO WHQJTreasureDBLink.WHQJTreasureDB.dbo.UserCurrency(UserID,Diamond) VALUES(@UserID,0)


  DECLARE @BeforeDiamond INT
  DECLARE @BeforeScore BIGINT
  DECLARE @BeforeInsure BIGINT
  SET @BeforeDiamond = 0
  SET @BeforeScore = 0
  SET @BeforeInsure=0
	-- ע��������ʯ
	DECLARE @PresentDiamond INT
	DECLARE @PresentGold INT
	SELECT @PresentDiamond=StatusValue FROM SystemStatusInfo WITH(NOLOCK) WHERE StatusName=N'JJRegisterDiamondCount'
	SELECT @PresentGold=StatusValue FROM SystemStatusInfo WITH(NOLOCK) WHERE StatusName=N'GrantScoreCount'
	IF (@PresentDiamond IS NULL OR @PresentDiamond<0) SET @PresentDiamond=0
	IF (@PresentGold IS NULL OR @PresentGold<0) SET @PresentGold=0
	IF @PresentDiamond>0
  BEGIN
		UPDATE WHQJTreasureDBLink.WHQJTreasureDB.dbo.UserCurrency SET Diamond=Diamond + @PresentDiamond WHERE UserID=@UserID

    INSERT INTO WHQJRecordDBLink.WHQJRecordDB.dbo.RecordDiamondSerial(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate)
		VALUES(dbo.WF_GetSerialNumber(),0,@UserID,1,@BeforeDiamond,@PresentDiamond,@strClientIP,GETDATE())
    SET @BeforeDiamond = @BeforeDiamond + @PresentDiamond
  END
  IF @PresentGold>0
	BEGIN
    UPDATE WHQJTreasureDBLink.WHQJTreasureDB.dbo.GameScoreInfo SET Score = Score + @PresentGold WHERE UserID=@UserID

    INSERT INTO WHQJRecordDBLink.WHQJRecordDB.dbo.RecordTreasureSerial(SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
		VALUES(dbo.WF_GetSerialNumber(),0,@UserID,1,@BeforeScore,@BeforeInsure,@PresentGold,@strClientIP,GETDATE())
    SET @BeforeScore = @BeforeScore + @PresentGold
	END

  -- ���ƹ�������ʯ
	IF @SpreaderID>0
	BEGIN
		DECLARE @bindReturn INT
		EXEC @bindReturn = WHQJAgentDB.DBO.NET_PB_UserAgentBind @dwUserID,@SpreaderGameID,@strClientIP,@strErrorDescribe OUTPUT
	END

	-- ��¼��־
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(@DateTime AS FLOAT) AS INT)
	UPDATE SystemStreamInfo SET WebRegisterSuccess=WebRegisterSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT SystemStreamInfo (DateID, WebRegisterSuccess) VALUES (@DateID, 1)

END

RETURN 0

GO
