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
	@strClientIP  NVARCHAR(15),	--�û�����IP

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
		SET @OriginSpreaderID = @SpreaderID
		SET @SpreaderID = @SpreaderAgent
	END

	-- ������Ǵ����򲻰�
	IF @SpreaderID = 0
	BEGIN
		-- ��Ϊ��ͨ�ƹ��ϵ
		SET @SpreaderID = @OriginSpreaderID
	END

	DECLARE @SpreaderAward INT
	SELECT @SpreaderAward = StatusValue FROM WHQJAccountsDB.DBO.SystemStatusInfo WHERE StatusName = N'JJBindSpreadPresent'
	IF @SpreaderAward IS NULL
	BEGIN
		SET @SpreaderAward = 0
	END

	IF @SpreaderAward > 0 
	BEGIN

		DECLARE @DateTime DateTime
		DECLARE @DiamondBefore INT
		SET @DateTime = GETDATE()
		-- ��ѯ�����ʯ
		SELECT @DiamondBefore = Diamond FROM WHQJTreasureDB.DBO.UserCurrency(NOLOCK) WHERE UserID = @dwUserID
		IF @DiamondBefore IS NULL
		BEGIN
			INSERT WHQJTreasureDB.DBO.UserCurrency (UserID,Diamond) VALUES (@dwUserID,0)
			SET @DiamondBefore = 0
		END

		UPDATE WHQJTreasureDB.DBO.UserCurrency 
			SET Diamond = Diamond + @SpreaderAward 
		 WHERE UserID = @dwUserID

		-- д����ʯ��ˮ��¼
		INSERT INTO WHQJRecordDB.DBO.RecordDiamondSerial
			(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate)
		VALUES(WHQJRecordDB.DBO.WF_GetSerialNumber(), 0, @UserID, 4, @DiamondBefore, @SpreaderAward, @strClientIP, @DateTime)

	END

	-- �󶨴����ϵ
	UPDATE WHQJAccountsDB.DBO.AccountsInfo SET SpreaderID = @SpreaderID WHERE UserID = @UserID
	IF (@AgentID > 0 OR @SpreaderAgent > 0)
	BEGIN 
		-- �����ϼ���������
		UPDATE AgentInfo SET BelowUser = BelowUser + 1 WHERE UserID = @SpreaderID
	END

	SET @strErrorDescribe = N'��ϲ�����󶨳ɹ���'
	RETURN 0
END
GO