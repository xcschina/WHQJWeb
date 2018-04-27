----------------------------------------------------------------------
-- �汾��2017
-- ʱ�䣺2017-11-15
-- ��;����ȡ��ֵ����
----------------------------------------------------------------------
USE [WHQJRecordDB]
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].[NET_PJ_ReceiveSpreadReturn]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PJ_ReceiveSpreadReturn]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PJ_ReceiveSpreadReturn]
  @dwUserID		INT,
  @dwNum   INT,
  @strClientIP NVARCHAR(15),
  @strErrorDescribe NVARCHAR(127) OUTPUT
WITH
  ENCRYPTION
AS

-- ��������
DECLARE @UserID INT
DECLARE @Nullity TINYINT
DECLARE @ReceiveType TINYINT
DECLARE @ReceiveCondition INT
DECLARE @DateTime DATETIME
DECLARE @TotalReturn BIGINT
DECLARE @TotalReceive BIGINT
DECLARE @ReceiveBefore BIGINT

-- ִ���߼�
BEGIN
  SET @DateTime = GETDATE()
  -- ��ȡ�û���Ϣ
  SELECT @UserID=UserID, @Nullity=Nullity
  FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK)
  WHERE UserID=@dwUserID
  
  IF @Nullity IS NULL
	BEGIN
    SET @strErrorDescribe=N'��Ǹ����ȡ�û�������'
    RETURN 1001
  END
  IF @Nullity=1
	BEGIN
    SET @strErrorDescribe=N'��Ǹ����ȡ�û��Ѷ���'
    RETURN 1002
  END

  -- ȫ���ƹ㷵�����
  SELECT @ReceiveType = StatusValue FROM WHQJAccountsDBLink.WHQJAccountsDB.DBO.SystemStatusInfo WHERE StatusName = N'SpreadReturnType'
  IF @ReceiveType IS NULL
  BEGIN
    SET @ReceiveType = 0;
  END

  -- ȫ���ƹ㷵������
  SELECT @ReceiveCondition = StatusValue FROM WHQJAccountsDBLink.WHQJAccountsDB.DBO.SystemStatusInfo WHERE StatusName = N'SpreadReceiveBase'
  IF @ReceiveCondition IS NULL
  BEGIN
    SET @ReceiveCondition = 0; -- ��ȡ����������
  END

  SELECT @TotalReturn =  CAST(ISNULL(SUM(ReturnNum),0) AS BIGINT)
  FROM RecordSpreadReturn
  WHERE TargetUserID=@UserID AND ReturnType = @ReceiveType
  SELECT @TotalReceive = CAST(ISNULL(SUM(ReceiveNum),0) AS BIGINT)
  FROM RecordSpreadReturnReceive
  WHERE UserID=@UserID AND ReceiveType = @ReceiveType
  IF @TotalReturn = 0 OR @dwNum>@TotalReturn-@TotalReceive
  BEGIN
    SET @strErrorDescribe=N'��Ǹ������ȡ��������'
    RETURN 2003
  END

  IF @TotalReturn-@TotalReceive < @ReceiveCondition
  BEGIN
    SET @strErrorDescribe=N'��Ǹ����ǰ��ȡ�ż�Ϊ����ȡ�����ڵ���'+LTRIM(STR(@ReceiveCondition)) +',��û����������'
    RETURN 2003
  END


  -- ��������
  BEGIN TRAN

  IF @ReceiveType = 1
  BEGIN
    -- ��ȡ����Ϊ��ʯ
    SELECT @ReceiveBefore = Diamond
    FROM WHQJTreasureDB.DBO.UserCurrency
    WHERE UserID = 0
    IF @ReceiveBefore IS NULL
    BEGIN
      SET @ReceiveBefore = 0
      INSERT INTO WHQJTreasureDB.DBO.UserCurrency
      VALUES(@UserID, 0)
    END

    UPDATE WHQJTreasureDB.DBO.UserCurrency SET Diamond = Diamond + @dwNum WHERE UserID = @UserID
    IF @@ROWCOUNT<=0
    BEGIN
      SET @strErrorDescribe=N'��Ǹ����ȡ�쳣�����Ժ�����'
      ROLLBACK TRAN
      RETURN 2004
    END

    -- д����ʯ��ˮ��¼
    INSERT INTO RecordDiamondSerial
      (SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate)
    VALUES(dbo.WF_GetSerialNumber(), 0, @UserID, 13, @ReceiveBefore, @dwNum, @strClientIP, @DateTime)
    IF @@ROWCOUNT<=0
    BEGIN
      SET @strErrorDescribe=N'��Ǹ����ȡ�쳣�����Ժ�����'
      ROLLBACK TRAN
      RETURN 2004
    END

  END
  IF @ReceiveType = 0
  BEGIN
    DECLARE @BeforeInsure BIGINT
    DECLARE @BeforeScore BIGINT
    -- ��ȡ����Ϊ���
    SELECT @BeforeScore = Score, @BeforeInsure = InsureScore
    FROM WHQJTreasureDB.DBO.GameScoreInfo
    WHERE UserID = @dwUserID
    IF @BeforeScore IS NULL AND @BeforeInsure IS NULL
    BEGIN
      SET @BeforeScore = 0
      SET @BeforeInsure = 0
      SET @ReceiveBefore = 0
      INSERT INTO WHQJTreasureDB.DBO.GameScoreInfo
        (UserID,Score,InsureScore,LastLogonIP)
      VALUES(@UserID, @BeforeScore, @BeforeInsure, @strClientIP)
    END
    SET @ReceiveBefore = @BeforeScore + @BeforeInsure
    UPDATE WHQJTreasureDB.DBO.GameScoreInfo SET Score = Score + @dwNum WHERE UserID = @UserID
    IF @@ROWCOUNT<=0
    BEGIN
      SET @strErrorDescribe=N'��Ǹ����ȡ�쳣�����Ժ�����'
      ROLLBACK TRAN
      RETURN 2004
    END

    -- д������ˮ��¼
    INSERT INTO RecordTreasureSerial
      (SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
    VALUES(dbo.WF_GetSerialNumber(), 0, @UserID, 9, @BeforeScore, @BeforeInsure, @dwNum, @strClientIP, @DateTime)
    IF @@ROWCOUNT<=0
    BEGIN
      SET @strErrorDescribe=N'��Ǹ����ȡ�쳣�����Ժ�����'
      ROLLBACK TRAN
      RETURN 2004
    END

  END

  -- д����ȡ��¼
  INSERT INTO RecordSpreadReturnReceive
    (UserID,ReceiveType,ReceiveNum,ReceiveBefore,ReceiveAddress,CollectDate)
  VALUES(@UserID, @ReceiveType, @dwNum, @ReceiveBefore, @strClientIP, @DateTime)
  IF @@ROWCOUNT<=0
  BEGIN
    SET @strErrorDescribe=N'��Ǹ����ȡ�쳣�����Ժ�����'
    ROLLBACK TRAN
    RETURN 2004
  END

  COMMIT TRAN

  RETURN 0
END
GO
