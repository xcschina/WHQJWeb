-- =============================================
-- ��;: ��ѯ�����ϵ �������¼������¼����ƣ��������ϼ������ϼ����ƣ�����ȡ�����������ߣ�����ֱ����ҡ��������ң���ע����Ϣ��
-- =============================================
/** ��ȡ���������¼���ϵ�����޼��� **/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WF_GetAgentBelowAgent]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[WF_GetAgentBelowAgent]
GO
-----------------------------------------------------------------
CREATE FUNCTION [dbo].[WF_GetAgentBelowAgent] 
(
	@dwAgentID INT = 0	--�û���ʶ
)
RETURNS 
@tbUserInfo TABLE 
(
	UserID INT ,
	AgentID INT,
	ParentAgent INT,
	LevelID INT 
)
WITH ENCRYPTION AS
BEGIN
	DECLARE @dwLevel INT
	SET  @dwLevel = 1
	INSERT  INTO  @tbUserInfo SELECT UserID,AgentID,ParentAgent,@dwLevel FROM WHQJAgentDB.DBO.AgentInfo(NOLOCK) WHERE AgentID = @dwAgentID
	WHILE @@ROWCOUNT > 0
	BEGIN 
		SET  @dwLevel = @dwLevel + 1
		INSERT  INTO  @tbUserInfo SELECT a.UserID,a.AgentID,a.ParentAgent,@dwLevel FROM WHQJAgentDB.DBO.AgentInfo(NOLOCK) a INNER JOIN  @tbUserInfo b ON a.ParentAgent = b.AgentID WHERE b.LevelID = @dwLevel - 1
	END 
	RETURN 
END
GO

/** ��ȡ���������ϼ���ϵ�����޼��� **/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WF_GetAgentAboveAgent]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[WF_GetAgentAboveAgent]
GO
-----------------------------------------------------------------
CREATE FUNCTION [dbo].[WF_GetAgentAboveAgent] 
(
	@dwAgentID INT = 0	--�û���ʶ
)
RETURNS 
@tbUserInfo TABLE 
(
	UserID INT ,
	AgentID INT,
	ParentAgent INT,
	LevelID INT 
)
WITH ENCRYPTION AS
BEGIN
	DECLARE  @dwLevel INT
	SET  @dwLevel = 1
	INSERT  INTO  @tbUserInfo SELECT UserID,AgentID,ParentAgent,@dwLevel FROM WHQJAgentDB.DBO.AgentInfo(NOLOCK) WHERE AgentID = @dwAgentID
	WHILE @@ROWCOUNT > 0
	BEGIN 
		SET  @dwLevel = @dwLevel + 1
		INSERT  INTO  @tbUserInfo SELECT a.UserID,a.AgentID,a.ParentAgent, @dwLevel AS LevelID FROM WHQJAgentDB.DBO.AgentInfo(NOLOCK) a INNER JOIN  @tbUserInfo b ON a.AgentID=b.ParentAgent WHERE b.LevelID = @dwLevel - 1 AND b.ParentAgent<>0
	END 
	RETURN 
END
GO

/** ��ȡ�����������ߣ�����ֱ����ҡ��������ң���ע����Ϣ **/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WF_GetAgentBelowUserRegister]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[WF_GetAgentBelowUserRegister]
GO
-----------------------------------------------------------------
CREATE FUNCTION [dbo].[WF_GetAgentBelowUserRegister] 
(
	@dwUserID INT = 0	--�û���ʶ
)
RETURNS 
@tbUserInfo TABLE 
(
	UserID INT ,
	SpreaderID INT,
	RegisterDate DATETIME,
	RegisterOrigin TINYINT,
	GameID INT,
	NickName NVARCHAR(31),
	AgentID INT
)
WITH ENCRYPTION AS
BEGIN
	IF @dwUserID = 0 RETURN
	DECLARE @AgentID INT
	SELECT @AgentID = AgentID FROM WHQJAgentDB.DBO.AgentInfo WHERE UserID = @dwUserID
	IF @AgentID IS NULL RETURN

	INSERT INTO @tbUserInfo  
	SELECT b.UserID,b.SpreaderID,b.RegisterDate,b.RegisterOrigin,b.GameID,b.NickName,b.AgentID FROM WHQJAccountsDB.DBO.AccountsInfo(NOLOCK) b LEFT JOIN AgentBelowInfo a ON a.UserID = b.UserID WHERE a.AgentID = @AgentID
	RETURN 
END
GO
