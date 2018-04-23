USE WHQJAgentDB
GO

----------------------------------------------------------------------------------------------------
-- ��Ȩ��2018
-- ʱ�䣺2018-04-17
-- ��;��������ȡ����
----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_AT_ReceiveAgentAward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_AT_ReceiveAgentAward]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

--------------------------------------------------------------------	
--
CREATE PROC [NET_AT_ReceiveAgentAward]
(
	@dwUserID			INT,					--�û���ʶ
	@dwAward	    INT,			-- ������׼
  @dwAwardType TINYINT,
  @strClientIP NVARCHAR(15), -- �û�IP

	@strErrorDescribe NVARCHAR(127) OUTPUT		--�����Ϣ
)

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �û���Ϣ
DECLARE @UserID INT
DECLARE @Nullity TINYINT
DECLARE @AgentID INT
DECLARE @DiamondAward INT
DECLARE @GoldAward INT

BEGIN
	-- ��ѯ�û�	
	SELECT @UserID=UserID,@Nullity=Nullity FROM WHQJAccountsDB.DBO.AccountsInfo WITH(NOLOCK) WHERE UserID=@dwUserID
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

	SELECT @AgentID=AgentID,@DiamondAward=DiamondAward,@GoldAward = GoldAward FROM AgentInfo WITH(NOLOCK) WHERE UserID=@UserID

  IF @AgentID IS NULL 
  BEGIN
    SET @strErrorDescribe=N'��Ǹ�������ʺŷǴ����޷���ȡ������'
    RETURN 1003
  END

  DECLARE @ReceiveBefore BIGINT
  DECLARE @DateTime DATETIME 
  SET @DateTime = GETDATE()

  IF @dwAwardType = 1
  BEGIN
    SELECT @ReceiveBefore = Diamond FROM WHQJTreasureDB.DBO.UserCurrency(NOLOCK) WHERE UserID = @UserID
    IF @ReceiveBefore IS NULL
    BEGIN
      INSERT WHQJTreasureDB.DBO.UserCurrency VALUES (@UserID,0)
      SET @ReceiveBefore = 0
    END

    DECLARE @ReceiveDiamondSave INT
    SELECT @ReceiveDiamondSave = StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName = N'ReceiveDiamondSave'
    IF @ReceiveDiamondSave IS NULL  SET @ReceiveDiamondSave = 0

    IF @DiamondAward - @ReceiveDiamondSave < @dwAward
    BEGIN
      SET @strErrorDescribe = N'��Ǹ��������ȡ�Ľ�����������ȡ��'
      RETURN 1004
    END

    -- ��������
    BEGIN TRAN

      -- д����ȡ��¼
      INSERT ReturnAwardReceive (UserID,AwardType,ReceiveAward,ReceiveBefore, CollectDate) 
      VALUES (@UserID,@dwAwardType,@dwAward,@ReceiveBefore, @DateTime)

      -- д����ʯ��ˮ��¼
      INSERT INTO WHQJRecordDB.DBO.RecordDiamondSerial
        (SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate)
      VALUES(dbo.WF_GetSerialNumber(), 0, @UserID, 13, @ReceiveBefore, @dwAward, @strClientIP, @DateTime)

      -- ���´�����Ϣ�еĿ��ý���
      UPDATE AgentInfo SET DiamondAward = DiamondAward - @dwAward WHERE UserID = @UserID
      -- �����û���ʯ����
      UPDATE WHQJTreasureDB.DBO.UserCurrency  SET Diamond = Diamond + @dwAward WHERE UserID = @UserID

      IF @@Error > 0 
      BEGIN
        ROLLBACK TRAN
        RETURN 2001
      END

    COMMIT TRAN
    
  END
  ELSE IF @dwAwardType = 2
  BEGIN
    DECLARE @ReceiveBeforeInsure BIGINT 
    SELECT @ReceiveBefore = Score,@ReceiveBeforeInsure = InsureScore FROM WHQJTreasureDB.DBO.GameScoreInfo(NOLOCK) WHERE UserID = @UserID
    IF @ReceiveBefore IS NULL
    BEGIN
      INSERT WHQJTreasureDB.DBO.GameScoreInfo(UserID,Score,InsureScore,RegisterIP) VALUES (@UserID,0,0,@strClientIP)
      SET @ReceiveBefore = 0
      SET @ReceiveBeforeInsure = 0
    END

    DECLARE @ReceiveGoldSave INT
    SELECT @ReceiveGoldSave = StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName = N'ReceiveGoldSave'
    IF @ReceiveGoldSave IS NULL  SET @ReceiveGoldSave = 0

    IF @GoldAward - @ReceiveGoldSave < @dwAward
    BEGIN
      SET @strErrorDescribe = N'��Ǹ��������ȡ�Ľ�����������ȡ��'
      RETURN 1004
    END

    IF EXISTS (SELECT 1 FROM WHQJTreasureDB.DBO.GameScoreLocker(NOLOCK) WHERE UserID = @UserID)
    BEGIN
      SET @strErrorDescribe = N'��Ǹ������ȡ����ǰ�����˳���Ϸ���䡣'
      RETURN 1005
    END

    -- ��������
    BEGIN TRAN

      -- д����ȡ��¼
      INSERT ReturnAwardReceive (UserID,AwardType,ReceiveAward,ReceiveBefore, CollectDate) 
      VALUES (@UserID,@dwAwardType,@dwAward,@ReceiveBefore, @DateTime)

      -- д������ˮ��¼
      INSERT INTO WHQJRecordDB.DBO.RecordTreasureSerial
      (SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
      VALUES(dbo.WF_GetSerialNumber(), 0, @UserID, 9, @ReceiveBefore, @ReceiveBeforeInsure, @dwAward, @strClientIP, @DateTime)


      -- ���´�����Ϣ�еĿ��ý���
      UPDATE AgentInfo SET GoldAward = GoldAward - @dwAward WHERE UserID = @UserID
      -- �����û��������
      UPDATE WHQJTreasureDB.DBO.GameScoreInfo  SET Score = Score + @dwAward WHERE UserID = @UserID

      IF @@Error > 0 
      BEGIN
        ROLLBACK TRAN
        RETURN 2001
      END

    COMMIT TRAN

  END
  ELSE 
  BEGIN
    SET @strErrorDescribe = N'��Ǹ����ȡ��������ȷ��'
    RETURN 1000
  END

  RETURN 0
END
GO