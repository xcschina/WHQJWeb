
----------------------------------------------------------------------
-- ʱ�䣺2011-09-26
-- ��;������Ա��¼
----------------------------------------------------------------------
USE WHQJPlatformManagerDB
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_UserLogon]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_UserLogon]
GO
-----------------------------------------------------------------------
CREATE PROC [NET_PM_UserLogon]
	@strUserName		NVARCHAR(31),					-- ����Ա�ʺ�
	@strPassword		NCHAR(32),						-- ��¼����
	@strClientIP		NVARCHAR(15),					-- ��¼IP
	@strErrorDescribe	NVARCHAR(127) OUTPUT			-- �����Ϣ
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON
DECLARE @UserID INT
DECLARE @Nullity INT 
DECLARE @RoleID INT
DECLARE @RoleName NVARCHAR(128)
DECLARE @PreLogintime DATETIME
DECLARE @PreLoginIP NVARCHAR(50)
DECLARE @NowTime DATETIME
DECLARE @LoginTimes INT

-- ִ���߼�
BEGIN	
	-- �˺���֤
	SELECT @UserID=UserID,@Nullity=Nullity,@RoleID=RoleID,@PreLogintime=LastLogintime,@PreLoginIP=LastLoginIP,@LoginTimes=LoginTimes FROM Base_Users WITH(NOLOCK) WHERE UserName=@strUserName AND [Password]=@strPassword
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe = N'��Ǹ�������ʺ���Ϣ����'
		RETURN 100
	END 
	IF @Nullity = 1
	BEGIN
		SET @strErrorDescribe = N'��Ǹ�������ʺ��Ѷ��ᣡ'
		RETURN 101
	END
	-- ��ɫ��Ϣ
	SELECT @RoleName=RoleName FROM Base_Roles WITH(NOLOCK) WHERE RoleID=@RoleID

	-- ���µ�¼��Ϣ
	SET @NowTime = GETDATE()
	UPDATE Base_Users SET LoginTimes=LoginTimes+1,PreLogintime=@PreLogintime,PreLoginIP=@PreLoginIP, LastLoginTime=@NowTime,LastLoginIP=@strClientIP WHERE UserID=@UserID

	-- ��¼��¼��Ϣ
	INSERT INTO SystemSecurity(OperatingTime,OperatingName,OperatingIP,OperatingAccounts) VALUES(@NowTime,'��̨��¼',@strClientIP,@strUserName)

	-- ������Ϣ
	SET @LoginTimes = @LoginTimes + 1
	SELECT @UserID AS UserID,@strUserName AS UserName,@RoleID AS RoleID,@RoleName AS RoleName,@LoginTimes AS LoginTimes,@PreLogintime AS PreLogintime,@PreLoginIP AS PreLoginIP

END
RETURN 0
GO