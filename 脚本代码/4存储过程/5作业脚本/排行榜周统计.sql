----------------------------------------------------------------------
-- �汾��2013
-- ʱ�䣺2013-04-22
-- ��;��ÿ��һͳ�����н���
----------------------------------------------------------------------
USE [WHQJNativeWebDB]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PJ_RankingWeekStatistics]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PJ_RankingWeekStatistics]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PJ_RankingWeekStatistics]
			
WITH ENCRYPTION AS

-- ��������
DECLARE @NOWTIME DATETIME
DECLARE @TIME DATETIME
DECLARE @DIFF INT
DECLARE @START DATETIME
DECLARE @ENT DATETIME
DECLARE @STARTDATE INT
DECLARE @ENDDATE INT
DECLARE @CCALC INT
DECLARE @SCALC INT
DECLARE @WCALC INT
DECLARE @DATEID INT

DECLARE @StatusValue INT

-- ִ���߼�
BEGIN
	-- ������ʱ��
	SET @NOWTIME = GETDATE()
	SET @DATEID = CAST(CAST(@NOWTIME AS FLOAT) AS INT)
	SET @TIME = @NOWTIME
	SET @DIFF = DATEPART(dw,@TIME)-1

	IF @DIFF=0
	BEGIN
		SET @START = DATEADD(DAY,-13,@TIME)
		SET @ENT = DATEADD(DAY,-7,@TIME)
	END
	ELSE
	BEGIN
		SET @ENT = DATEADD(DAY,-@DIFF,@TIME)
		SET @START = DATEADD(DAY,-6,@ENT)
	END
	SET @STARTDATE = CAST(CAST(@START AS FLOAT) AS INT)
	SET @ENDDATE = CAST(CAST(@ENT AS FLOAT) AS INT)

	-- ��ȡ���а�����
	SELECT @StatusValue = StatusValue FROM WHQJAccountsDB.dbo.SystemStatusInfo WITH(NOLOCK) WHERE StatusName=N'JJRankingListType'
	IF @StatusValue>0
	BEGIN
		-- �������
		TRUNCATE TABLE CacheRankValue
		-- ��ȡ����ֵ
		SET @CCALC = @StatusValue&2
		SET @SCALC = @StatusValue&4
		SET @WCALC = @StatusValue&1

		-- �Ƹ����а�
		IF @WCALC=1
		BEGIN
			INSERT INTO CacheRankValue(RankID,UserID,TypeID,RankValue) 
				SELECT ROW_NUMBER() OVER(ORDER BY Diamond DESC,UserID ASC) AS RankID,UserID,1 AS TypeID,Diamond AS RankValue FROM CacheWealthRank WHERE DateID = @ENDDATE ORDER BY Diamond DESC,UserID ASC
		END
		-- �������а�
		IF @CCALC=2
		BEGIN
			INSERT INTO CacheRankValue(RankID,UserID,TypeID,RankValue) 
			SELECT ROW_NUMBER() OVER(ORDER BY SUM(Diamond) DESC,UserID ASC) AS RankID,UserID,2 AS TypeID,ISNULL(SUM(Diamond),0) AS RankValue FROM CacheConsumeRank WHERE DateID>=@STARTDATE AND DateID<=@ENDDATE GROUP BY UserID ORDER BY SUM(Diamond) DESC,UserID ASC
		END
		-- ս�����а�
		IF @SCALC=4
		BEGIN
			INSERT INTO CacheRankValue(RankID,UserID,TypeID,RankValue) 
			SELECT ROW_NUMBER() OVER(ORDER BY SUM(Score) DESC,UserID ASC) AS RankID,UserID,4 AS TypeID,ISNULL(SUM(Score),0) AS RankValue FROM CacheScoreRank WHERE DateID>=@STARTDATE AND DateID<=@ENDDATE GROUP BY UserID ORDER BY SUM(Score) DESC,UserID ASC
		END

		-- д�뽱����¼��
		INSERT INTO RecordRankingRecevie(DateID,UserID,GameID,NickName,SystemFaceID,FaceUrl,TypeID,RankID,RankValue,Diamond,ValidityTime,ReceiveState,CollectDate) 
		SELECT @DATEID AS DateID,C.UserID,A.GameID,A.NickName,A.FaceID,ISNULL(F.FaceUrl,''),C.TypeID,C.RankID,C.RankValue,R.Diamond,DATEADD(DAY,R.ValidityTime,@NOWTIME) AS ValidityTime,0 AS ReceiveState,@NOWTIME AS CollectDate FROM RankingConfig AS R 
		LEFT JOIN CacheRankValue AS C ON R.RankID=C.RankID AND R.TypeID=C.TypeID LEFT JOIN WHQJAccountsDB.dbo.AccountsInfo AS A ON C.UserID=A.UserID LEFT JOIN WHQJAccountsDB.dbo.AccountsFace AS F ON C.UserID=F.UserID WHERE C.UserID <> NULL
	END
END
GO

