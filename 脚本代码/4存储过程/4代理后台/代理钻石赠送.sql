----------------------------------------------------------------------------------------------------
-- ��Ȩ��2011
-- ʱ�䣺2012-02-23
-- ��;��������ʯ����
----------------------------------------------------------------------------------------------------

USE WHQJTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_AgentPresentDiamond') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_AgentPresentDiamond
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE NET_PW_AgentPresentDiamond
	@dwUserID	INT,						-- �û� I D
	@dwPresentCount INT,					-- ��������
	@dwGameID INT,							-- ����ID
	@strPassword NCHAR(32),					-- ��ȫ����
	@strNote	NVARCHAR(63),				-- ���ͱ�ע
	@strClientIP NVARCHAR(15),				-- ������ַ
	@strErrorDescribe NVARCHAR(127) OUTPUT	-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �û���Ϣ
DECLARE @UserID INT
DECLARE @Nullity BIT
DECLARE @StunDown BIT
DECLARE @Password NVARCHAR(32)
DECLARE @SDiamond BIGINT
DECLARE @AgentID INT
DECLARE @TAgentID INT
DECLARE @ParentAgent INT
DECLARE @SpreaderID INT

DECLARE @TUserID INT
DECLARE @TDiamond BIGINT
DECLARE @TAgentLevel TINYINT

DECLARE @DateTime DATETIME

-- ִ���߼�
BEGIN
	SET @DateTime = GETDATE()
	-- ��ѯ�û�
	SELECT @UserID=UserID, @Nullity=Nullity, @StunDown=StunDown,@AgentID=AgentID FROM WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID=@dwUserID
	SELECT @TUserID=UserID,@SpreaderID=SpreaderID,@TAgentID=AgentID FROM WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE GameID=@dwGameID

	-- ��ѯ�û�
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������˺Ų����ڣ�'
		RETURN 1001
	END	
	--IF @AgentID<=0
	--BEGIN
	--	SET @strErrorDescribe=N'��Ǹ�������˺�Ϊ�Ǵ����˺ţ�'
	--	RETURN 1002
	--END
	IF @TUserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ������Ŀ���˺Ų����ڣ�'
		RETURN 1003
	END

	-- �ʺŽ�ֹ
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������˺��Ѷ���״̬��'
		RETURN 1004
	END	

	-- �ʺŹر�
	IF @StunDown=1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�������˺��ѿ�����ȫ�رչ��ܣ�'
		RETURN 1005
	END		

	-- ��֤��ȫ����
	SELECT @Password=[Password] FROM WHQJAccountsDB.dbo.AccountsAgentInfo WITH(NOLOCK) WHERE AgentID=@AgentID
	IF @Password=N''
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�����İ�ȫ����δ���ã�'
		RETURN 2001
	END
	IF @Password IS NULL OR @Password!=@strPassword
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�����İ�ȫ�������'
		RETURN 2002
	END

	-- ��֤Ŀ���˺ż���
	SELECT @ParentAgent=ParentAgent,@TAgentLevel=AgentLevel FROM WHQJAccountsDB.dbo.AccountsAgentInfo WITH(NOLOCK) WHERE AgentID=@TAgentID
	IF @TAgentID>0 AND @ParentAgent!=@AgentID
	BEGIN
		SET @strErrorDescribe=N'��Ǹ������ֻ�ܸ��Լ��������ͣ�'
		RETURN 3001
	END
	IF @TAgentLevel IS NULL SET @TAgentLevel =0


	-- ��������
	BEGIN TRAN

	SELECT @SDiamond=Diamond FROM UserCurrency WITH(ROWLOCK) WHERE UserID=@UserID
	IF @SDiamond IS NULL OR @SDiamond < @dwPresentCount
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��������ʯ���㣬���ȳ�ֵ��'
		ROLLBACK TRAN
		RETURN 4001
	END

	UPDATE UserCurrency SET Diamond = Diamond - @dwPresentCount WHERE UserID=@UserID
	IF @@ROWCOUNT <= 0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��������ʯʧ�ܣ�'
		ROLLBACK TRAN
		RETURN 4002
	END

	SELECT @TDiamond=Diamond FROM UserCurrency WHERE UserID = @TUserID
	IF @TDiamond IS NULL
	BEGIN
		SET @TDiamond = 0
		INSERT INTO UserCurrency VALUES(@TUserID,@dwPresentCount)
	END
	ELSE
	BEGIN
		UPDATE UserCurrency SET Diamond = Diamond + @dwPresentCount WHERE UserID = @TUserID
	END

	IF @@ROWCOUNT <= 0
	BEGIN
		SET @strErrorDescribe=N'��Ǹ��������ʯʧ�ܣ�'
		ROLLBACK TRAN
		RETURN 4003
	END

	COMMIT TRAN

	-- д�������¼
	INSERT INTO WHQJRecordDB.dbo.RecordPresentCurrency(SourceUserID,SourceDiamond,TargetUserID,TargetDiamond,TargetAgentLevel,PresentDiamond,ClientIP,CollectDate,CollectNote) 
	VALUES(@UserID,@SDiamond,@TUserID,@TDiamond,@TAgentLevel,@dwPresentCount,@strClientIP,@DateTime,@strNote)
	
	-- д����ʯ��ˮ��¼
	INSERT INTO WHQJRecordDB.dbo.RecordDiamondSerial(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate) 
	VALUES(dbo.WF_GetSerialNumber(),0,@UserID,7,@SDiamond,-@dwPresentCount,@strClientIP,@DateTime)
	INSERT INTO WHQJRecordDB.dbo.RecordDiamondSerial(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate) 
	VALUES(dbo.WF_GetSerialNumber(),0,@TUserID,8,@TDiamond,@dwPresentCount,@strClientIP,@DateTime)

	SET @strErrorDescribe=N'���ͳɹ���' 
END

RETURN 0

GO