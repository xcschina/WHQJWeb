USE WHQJAgentDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PB_RecordAgentAward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PB_RecordAgentAward]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

--------------------------------------------------------------------	
--
CREATE PROC [NET_PB_RecordAgentAward]
(
	@dwUserID			INT,					--�û���ʶ
	@dwReturnBase	INT,			-- ������׼
	@dwAwardType TINYINT,

	@strErrorDescribe NVARCHAR(127) OUTPUT		--�����Ϣ
)

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �û���Ϣ
DECLARE @UserID INT
DECLARE @Nullity TINYINT
DECLARE @SpreaderID INT


BEGIN
	-- ��ѯ�û�	
	SELECT @UserID=UserID,@Nullity=Nullity,@SpreaderID=SpreaderID FROM WHQJAccountsDB.DBO.AccountsInfo WITH(NOLOCK) WHERE UserID=@dwUserID

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

  IF @SpreaderID = 0 
  BEGIN
    SET @strErrorDescribe=N'��Ǹ���ʺ�δ�������޽�������'
    RETURN 1003
  END

	
  -- ������ڷ������ã�д�뷵����¼
	IF EXISTS (SELECT 1 FROM ReturnAwardConfig WHERE Nullity = 0 AND AwardType = @dwAwardType)
	BEGIN

    DECLARE @DateTime DateTime
    SET @DateTime = GETDATE()

		INSERT ReturnAwardRecord(SourceUserID,TargetUserID,ReturnBase,Awardlevel,AwardScale,Award,AwardType,CollectDate)
		SELECT @UserID,A.UserID,@dwReturnBase,B.AwardLevel,B.AwardScale,@dwReturnBase*B.AwardScale,B.AwardType,@DateTime FROM (SELECT UserID,LevelID FROM [dbo].[WF_GetAgentAboveAgent](@SpreaderID) ) AS A,ReturnAwardConfig AS B WHERE B.AwardLevel=A.LevelID AND A.LevelID<=3 AND B.Nullity=0 AND B.AwardType = @dwAwardType

    DECLARE @DateID INT
    SET @DateID = CAST (CAST (@DateTime AS FLOAT) AS INT)
    SELECT @DateID

    UPDATE ReturnAwardSteam 
      SET ReturnAwardSteam.Award = ReturnAwardSteam.Award + B.Award
        ,UpdateTime = @DateTime
    FROM ReturnAwardRecord B
    WHERE DateID = @DateID AND ReturnAwardSteam.UserID = B.TargetUserID AND ReturnAwardSteam.AwardType = B.AwardType AND ReturnAwardSteam.AwardLevel = B.AwardLevel AND B.SourceUserID = @UserID AND B.CollectDate = @DateTime
    IF @@ROWCOUNT < 3
    BEGIN
      INSERT ReturnAwardSteam(DateID,UserID,AwardType,AwardLevel,Award,InsertTime)
      SELECT @DateID,TargetUserID,AwardType,AwardLevel,Award,@DateTime FROM ReturnAwardRecord WHERE AwardType = @dwAwardType AND SourceUserID = @UserID AND CollectDate = @DateTime
    END

    IF @dwAwardType = 1
    BEGIN
      UPDATE AgentInfo
        SET DiamondAward = DiamondAward + B.Award
      FROM ReturnAwardRecord B
      WHERE AgentInfo.UserID = B.TargetUserID AND B.SourceUserID = @UserID AND B.CollectDate = @DateTime
    END
    IF @dwAwardType = 2
    BEGIN
      UPDATE AgentInfo
        SET GoldAward = GoldAward + B.Award
      FROM ReturnAwardRecord B
      WHERE AgentInfo.UserID = B.TargetUserID AND B.SourceUserID = @UserID AND B.CollectDate = @DateTime
    END

	END

END
RETURN 0
GO