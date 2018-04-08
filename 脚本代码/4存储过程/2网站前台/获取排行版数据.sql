----------------------------------------------------------------------------------------------------
-- ��Ȩ��2011
-- ʱ�䣺2012-02-23
-- ��;����ȡ���а�����(ÿ�յ����а�)
----------------------------------------------------------------------------------------------------

USE WHQJNativeWebDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_GetDayRankingData') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_GetDayRankingData
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE NET_PW_GetDayRankingData
	@TypeID INT
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

DECLARE @Yesterday DATETIME
DECLARE @DateID INT

-- ִ���߼�
BEGIN
	-- ��ȡʱ��
	SET @Yesterday = DATEADD(DAY,-1,GETDATE())
	SET @DateID = CAST(CAST(@Yesterday AS FLOAT) AS INT)

	-- ��ȡ��ʯ����
	IF @TypeID & 1 = 1
	BEGIN
		SELECT TOP 10 * FROM CacheWealthRank WITH(NOLOCK) WHERE DateID = @DateID ORDER BY RankNum ASC
	END
	-- ��ȡ��������
	IF @TypeID & 2 = 2
	BEGIN
		SELECT TOP 10 * FROM CacheConsumeRank WITH(NOLOCK) WHERE DateID = @DateID ORDER BY RankNum ASC
	END
	-- ��ȡս������
	IF @TypeID & 4 = 4
	BEGIN
		SELECT TOP 10 * FROM CacheScoreRank WITH(NOLOCK) WHERE DateID = @DateID ORDER BY RankNum ASC
	END
	
END

RETURN 0

GO