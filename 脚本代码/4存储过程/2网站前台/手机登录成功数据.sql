----------------------------------------------------------------------------------------------------
-- 版权：2011
-- 时间：2012-02-23
-- 用途：手机登录数据获取
----------------------------------------------------------------------------------------------------

USE WHQJAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_GetMobileLoginLater') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_GetMobileLoginLater
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE NET_PW_GetMobileLoginLater
	@dwUserID INT
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @StatusValue INT
DECLARE @AgentID INT
DECLARE @GameID INT
DECLARE @AgentDomain NVARCHAR(50)

-- 执行逻辑
BEGIN
	-- 查询用户代理
	SELECT @AgentID = AgentID,@GameID = GameID FROM AccountsInfo WITH(NOLOCK) WHERE UserID=@dwUserID
	IF @AgentID>0
	BEGIN
		SELECT @AgentDomain = AgentDomain FROM AccountsAgentInfo WITH(NOLOCK) WHERE AgentID=@AgentID
	END
	SELECT @AgentID AS AgentID,@GameID AS GameID,@AgentDomain AS AgentDomain

	-- 注册奖励记录
	SELECT GrantDiamond,GrantGold FROM WHQJRecordDB.dbo.RecordRegisterGrant WITH(NOLOCK) WHERE UserID = @dwUserID AND IsReceive=0

	-- 获取玩家推广人配置
	SELECT S.ConfigID,S.SpreadNum,S.PresentDiamond,S.PresentPropID,S.PresentPropName,S.PresentPropNum,
	CASE WHEN R.RecordID IS NULL THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS Flag FROM WHQJTreasureDB.dbo.SpreadConfig AS S WITH(NOLOCK)
	LEFT JOIN WHQJTreasureDB.dbo.RecordSpreadAward AS R WITH(NOLOCK) ON S.ConfigID = R.ConfigID AND R.UserID = @dwUserID

	-- 排行版数据
	SELECT R.DateID,R.UserID,R.GameID,R.NickName,R.SystemFaceID,R.FaceUrl,R.TypeID,R.RankID,R.RankValue,R.Diamond FROM WHQJNativeWebDB.dbo.RecordRankingRecevie AS R WITH(NOLOCK) INNER JOIN
	(SELECT DateID,TypeID FROM WHQJNativeWebDB.dbo.RecordRankingRecevie WITH(NOLOCK) WHERE UserID=@dwUserID AND ReceiveState=0 AND ValidityTime>GETDATE()) AS A ON R.DateID=A.DateID AND R.TypeID=A.TypeID

	-- 有效好友数
	SELECT @StatusValue=StatusValue FROM SystemStatusInfo WITH(NOLOCK) WHERE StatusName IN('JJEffectiveFriendGame')
	IF @StatusValue IS NULL SET @StatusValue=1
	SELECT COUNT(UserID) AS Total FROM (SELECT z.UserID AS UserID,COUNT(z.UserID) AS UCount,COUNT(x.UserID) AS JCount FROM WHQJPlatformDB.dbo.PersonalRoomScoreInfo(NOLOCK) AS z,WHQJTreasureDB.dbo.RecordDrawScoreForWeb(NOLOCK) x
	WHERE z.UserID=x.UserID AND z.UserID IN (SELECT UserID FROM AccountsInfo WITH(NOLOCK) WHERE SpreaderID = @dwUserID) GROUP BY z.UserID HAVING COUNT(x.UserID)+COUNT(z.UserID)>@StatusValue) AS P

END

RETURN 0

GO
