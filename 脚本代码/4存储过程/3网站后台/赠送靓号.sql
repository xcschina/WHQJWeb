----------------------------------------------------------------------
-- ʱ�䣺2010-03-16
-- ��;����������
----------------------------------------------------------------------
USE WHQJRecordDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[WSP_PM_GrantGameID]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[WSP_PM_GrantGameID]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO
----------------------------------------------------------------------


CREATE PROCEDURE WSP_PM_GrantGameID
	@MasterID INT,								-- ����Ա��ʶ
	@UserID INT,								-- �û���ʶ
	@ReGameID INT,								-- ����ID
	@ClientIP VARCHAR(15),						-- ���͵�ַ
	@Reason NVARCHAR(32),						-- ����ԭ��
	@strErrorDescribe NVARCHAR(127)	OUTPUT		-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �û���Ϣ
DECLARE @CurGameID BIGINT
DECLARE @dwUserID INT

-- ����ID��Ϣ
DECLARE @dwGameID INT
DECLARE @IDLevel INT

-- ���ز���
DECLARE @ReturnValue NVARCHAR(127)

-- ִ���߼�
BEGIN
	
	-- ��ȡ��ϷID
	SELECT @CurGameID = GameID FROM WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID = @UserID

	-- �ж�
	SELECT @dwGameID = GameID,@IDLevel = IDLevel FROM WHQJAccountsDB.dbo.ReserveIdentifier WITH(NOLOCK) WHERE GameID = @ReGameID
	IF @dwGameID IS NULL
	BEGIN
		SET @strErrorDescribe = N'��Ǹ�����͵����Ų����ڣ�'
		RETURN 1001
	END

	SELECT @dwUserID = UserID FROM WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE GameID = @ReGameID
	IF @dwUserID IS NOT NULL
	BEGIN
		SET @strErrorDescribe = N'��Ǹ�����͵�������ռ�ã�'
		RETURN 1002
	END	

	-- ������¼
	INSERT INTO RecordGrantGameID(MasterID,UserID,CurGameID,ReGameID,IDLevel,ClientIP,Reason)
	VALUES(@MasterID,@UserID,@CurGameID,@ReGameID,@IDLevel,@ClientIP,@Reason)

	-- ���±�����
	UPDATE WHQJAccountsDB.dbo.ReserveIdentifier SET Distribute = 1 WHERE GameID = @ReGameID

	-- �����û���
	UPDATE WHQJAccountsDB.dbo.AccountsInfo SET GameID = @ReGameID WHERE UserID = @UserID

END
RETURN 0
GO