----------------------------------------------------------------------------------------------------
-- ��Ȩ��2017
-- ʱ�䣺2017-11-16
-- ��;���û�������������
----------------------------------------------------------------------------------------------------

USE WHQJAccountsDB
GO

IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PW_UserSpreadHome') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_UserSpreadHome
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

-- �ʺ�ע��
CREATE PROCEDURE NET_PW_UserSpreadHome
  @dwUserID			INT
-- �û���ʶ
WITH
  ENCRYPTION
AS

-- ��������
SET NOCOUNT ON

-- ������Ϣ
DECLARE @UserID INT
DECLARE @GameID INT

-- ��չ��Ϣ
DECLARE @TypeID TINYINT
DECLARE @Lv1Count INT
DECLARE @Lv2Count INT
DECLARE @Lv3Count INT
DECLARE @TotalReturn BIGINT
DECLARE @TotalReceive BIGINT

-- ִ���߼�
BEGIN

  SELECT @TypeID = StatusValue FROM WHQJAccountsDB.dbo.SystemStatusInfo WHERE StatusName = N'SpreadReturnType'
  IF @TypeID IS NULL
  BEGIN
    SET @TypeID = 0
  END

  SELECT @UserID=UserID, @GameID=GameID
  FROM WHQJAccountsDB.dbo.AccountsInfo
  WHERE UserID=@dwUserID

  SELECT @Lv1Count = COUNT(UserID)
  FROM [dbo].WF_GetAgentBelowAccounts (@dwUserID)
  WHERE LevelID = 2

  SELECT @Lv2Count = COUNT(UserID)
  FROM [dbo].WF_GetAgentBelowAccounts (@dwUserID)
  WHERE LevelID = 3

  SELECT @Lv3Count = COUNT(UserID)
  FROM [dbo].WF_GetAgentBelowAccounts (@dwUserID)
  WHERE LevelID = 4

  SELECT @TotalReturn = CAST(ISNULL(SUM(ReturnNum),0) AS BIGINT)
  FROM WHQJRecordDB.dbo.RecordSpreadReturn(NOLOCK)
  WHERE TargetUserID=@dwUserID AND ReturnType=@TypeID

  SELECT @TotalReceive = CAST(ISNULL(SUM(ReceiveNum),0) AS BIGINT)
  FROM WHQJRecordDB.dbo.RecordSpreadReturnReceive(NOLOCK)
  WHERE UserID=@dwUserID AND ReceiveType=@TypeID

  -- ������Ϣ
  SELECT @UserID AS UserID, @GameID AS GameID, @Lv1Count AS Lv1Count, @Lv2Count AS Lv2Count,
    @Lv3Count AS Lv3Count, @TotalReturn AS TotalReturn, @TotalReceive AS TotalReceive

  -- �����������������
  SELECT UserID, LevelID-1 AS LevelID
  FROM [DBO].WF_GetAgentBelowAccounts (@dwUserID)
  WHERE LevelID>1 AND LevelID<=4

  -- ���100��������¼
  SELECT TOP 100
    *
  FROM WHQJRecordDB.dbo.RecordSpreadReturn(NOLOCK)
  WHERE TargetUserID = @dwUserID AND ReturnType = @TypeID
  ORDER BY CollectDate DESC

  -- ���100����ȡ��¼
  SELECT TOP 100
    *
  FROM WHQJRecordDB.dbo.RecordSpreadReturnReceive(NOLOCK)
  WHERE UserID = @dwUserID AND ReceiveType = @TypeID
  ORDER BY CollectDate DESC

END

RETURN 0

GO
