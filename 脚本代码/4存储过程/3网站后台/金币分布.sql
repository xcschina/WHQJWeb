----------------------------------------------------------------------------------------------------
-- ��Ȩ��2011
-- ʱ�䣺2012-02-23
-- ��;����̨��ѯ��ҷֲ�
----------------------------------------------------------------------------------------------------

USE WHQJTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_GetGoldDistribute') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_GetGoldDistribute
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE NET_PW_GetGoldDistribute

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	-- ��ȡ��ҷֲ�
	SELECT '1������' AS name, COUNT(UserID) AS value FROM GameScoreInfo WITH(NOLOCK) WHERE (Score+InsureScore)<10000 UNION ALL 
	SELECT '1��~10��' AS name, COUNT(UserID) AS value FROM GameScoreInfo WITH(NOLOCK) WHERE (Score+InsureScore)>=10000 AND (Score+InsureScore)<100000 UNION ALL 
	SELECT '10��~50��' AS name, COUNT(UserID) AS value FROM GameScoreInfo WITH(NOLOCK) WHERE (Score+InsureScore)>=100000 AND (Score+InsureScore)<500000 UNION ALL 
	SELECT '50��~100��' AS name, COUNT(UserID) AS value FROM GameScoreInfo WITH(NOLOCK) WHERE (Score+InsureScore)>=500000 AND (Score+InsureScore)<1000000 UNION ALL 
	SELECT '100��~500��' AS name, COUNT(UserID) AS value FROM GameScoreInfo WITH(NOLOCK) WHERE (Score+InsureScore)>=1000000 AND (Score+InsureScore)<5000000 UNION ALL 
	SELECT '500��~1000��' AS name, COUNT(UserID) AS value FROM GameScoreInfo WITH(NOLOCK) WHERE (Score+InsureScore)>=5000000 AND (Score+InsureScore)<10000000 UNION ALL 
	SELECT '1000��~5000��' AS name, COUNT(UserID) AS value FROM GameScoreInfo WITH(NOLOCK) WHERE (Score+InsureScore)>=10000000 AND (Score+InsureScore)<50000000 UNION ALL 
	SELECT '5000������' AS name, COUNT(UserID) AS value FROM GameScoreInfo WITH(NOLOCK) WHERE (Score+InsureScore)>=50000000

	-- ��ȡ�������
	SELECT ISNULL(SUM(Score),0) AS Score,ISNULL(SUM(InsureScore),0) AS InsureScore FROM GameScoreInfo WITH(NOLOCK)

END

RETURN 0

GO
