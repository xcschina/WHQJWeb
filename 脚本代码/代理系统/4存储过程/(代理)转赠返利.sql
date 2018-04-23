USE WHQJAgentDB
GO

----------------------------------------------------------------------------------------------------
-- ��Ȩ��2018
-- ʱ�䣺2018-04-18
-- ��;������ת�����������ݹ��ܿ��Ե������� Ҳ������ȡ�������ʹ�ã�
----------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_AT_GiveAgentAward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_AT_GiveAgentAward]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

--------------------------------------------------------------------	
--
CREATE PROC [NET_AT_GiveAgentAward]
(
	@dwUserID			INT,					-- �����û���ʶ
	@dwAward	    INT,			  -- ��������
	@dwAwardType  TINYINT,     -- �������� 1����ʯ 2�����
	@strPassword  NVARCHAR(32),  -- ����ȫ����
	@dwGameID     INT,        -- Ŀ��GameID
	@strClientIP  NVARCHAR(15), -- �û�IP

	@strErrorDescribe NVARCHAR(127) OUTPUT		--�����Ϣ
)

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �û���Ϣ
DECLARE @UserID INT
DECLARE @Nullity TINYINT
DECLARE @AgentNullity TINYINT
DECLARE @AgentID INT
DECLARE @Password NVARCHAR(32)

-- ��ת���û���Ϣ
DECLARE @TargetUserID INT
DECLARE @TargetNullity TINYINT

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

  -- ��ѯ�������û�
  SELECT @TargetUserID = UserID,@TargetNullity = Nullity FROM WHQJAccountsDB.DBO.AccountsInfo WITH(NOLOCK) WHERE GameID=@dwGameID
  -- �û�����
  IF @TargetUserID IS NULL
  BEGIN
    SET @strErrorDescribe=N'��Ǹ����ת�����˺Ų����ڣ�'
    RETURN 1003
  END

  IF @TargetNullity=1
  BEGIN
    SET @strErrorDescribe=N'��Ǹ����ת�����˺��Ѷ��ᣡ'
    RETURN 1004
  END

	SELECT @AgentID=AgentID,@AgentNullity = Nullity,@Password = [Password] FROM AgentInfo WITH(NOLOCK) WHERE UserID=@UserID

  IF @AgentID IS NULL 
  BEGIN
    SET @strErrorDescribe=N'��Ǹ�������ʺŷǴ����޷���ȡ������'
    RETURN 1005
  END

  IF @AgentNullity=1 
  BEGIN
    SET @strErrorDescribe=N'��Ǹ�����Ĵ����ʺ��Ѷ��ᣡ'
    RETURN 1006
  END

  IF @strPassword <> @Password
  BEGIN
    SET @strErrorDescribe=N'��Ǹ�����İ�ȫ���벻��ȷ��'
    RETURN 1007
  END

  DECLARE @GiveBefore BIGINT
  DECLARE @ReceiveBefore BIGINT
  DECLARE @DateTime DATETIME 
  SET @DateTime = GETDATE()

  IF @dwAwardType = 1
  BEGIN
    SELECT @GiveBefore = Diamond FROM WHQJTreasureDB.DBO.UserCurrency(NOLOCK) WHERE UserID = @UserID
    IF @GiveBefore IS NULL
    BEGIN
      INSERT WHQJTreasureDB.DBO.UserCurrency VALUES (@UserID,0)
      SET @GiveBefore = 0
    END
	
	IF @dwAward>@GiveBefore
	BEGIN
	  SET @strErrorDescribe=N'��Ǹ������������ת����'
	  RETURN 1008
	END

    SELECT @ReceiveBefore = Diamond FROM WHQJTreasureDB.DBO.UserCurrency(NOLOCK) WHERE UserID = @TargetUserID
    IF @ReceiveBefore IS NULL
    BEGIN
      INSERT WHQJTreasureDB.DBO.UserCurrency VALUES (@TargetUserID,0)
      SET @ReceiveBefore = 0
    END

    -- ��������
    BEGIN TRAN

      -- д��ת����¼
      INSERT ReturnAwardGrant (SourceUserID,TargetUserID,TradeType,SourceBefore,TargetBefore,Amount,ClientIP,CollectDate) 
      VALUES (@UserID,@TargetUserID,@dwAwardType,@GiveBefore,@ReceiveBefore,@dwAward,@strClientIP,@DateTime)

      -- д����ʯ��ˮ��¼ ת���� TypeID=7 ����ת��
      INSERT INTO WHQJRecordDB.DBO.RecordDiamondSerial
        (SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate)
      VALUES(dbo.WF_GetSerialNumber(), 0, @UserID, 7, @GiveBefore, -@dwAward, @strClientIP, @DateTime)
      -- д����ʯ��ˮ��¼ ת�뷽 TypeID=8 ������ת��
      INSERT INTO WHQJRecordDB.DBO.RecordDiamondSerial
        (SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate)
      VALUES(dbo.WF_GetSerialNumber(), 0, @TargetUserID, 8, @ReceiveBefore, @dwAward, @strClientIP, @DateTime)

      -- ���´����û���ʯ����
      UPDATE WHQJTreasureDB.DBO.UserCurrency SET Diamond = Diamond - @dwAward WHERE UserID = @UserID
      -- ���±�ת���û���ʯ����
      UPDATE WHQJTreasureDB.DBO.UserCurrency  SET Diamond = Diamond + @dwAward WHERE UserID = @TargetUserID

      IF @@Error > 0 
      BEGIN
        ROLLBACK TRAN
        RETURN 2003
      END

    COMMIT TRAN
    
  END
  ELSE IF @dwAwardType = 2
  BEGIN
    DECLARE @GiveBeforeInsure BIGINT 
    DECLARE @ReceiveBeforeInsure BIGINT 
    SELECT @GiveBefore = Score,@GiveBeforeInsure = InsureScore FROM WHQJTreasureDB.DBO.GameScoreInfo(NOLOCK) WHERE UserID = @UserID
    IF @GiveBefore IS NULL
    BEGIN
      INSERT WHQJTreasureDB.DBO.GameScoreInfo(UserID,Score,InsureScore,RegisterIP) VALUES (@UserID,0,0,@strClientIP)
      SET @GiveBefore = 0
      SET @GiveBeforeInsure = 0
    END

	IF @dwAward>@GiveBefore
	BEGIN
	  SET @strErrorDescribe=N'��Ǹ������������ת����'
	  RETURN 1008
	END

    SELECT @ReceiveBefore = Score,@ReceiveBeforeInsure = InsureScore FROM WHQJTreasureDB.DBO.GameScoreInfo(NOLOCK) WHERE UserID = @TargetUserID
    IF @ReceiveBefore IS NULL
    BEGIN
      INSERT WHQJTreasureDB.DBO.GameScoreInfo(UserID,Score,InsureScore) VALUES (@TargetUserID,0,0)
      SET @ReceiveBefore = 0
      SET @ReceiveBeforeInsure = 0
    END

    -- ����ҷ�������
    IF EXISTS (SELECT 1 FROM WHQJTreasureDB.DBO.GameScoreLocker(NOLOCK) WHERE UserID = @UserID OR UserID = @TargetUserID)
    BEGIN
      SET @strErrorDescribe = N'��Ǹ�����뱻ת�����û��������˳���Ϸ���䡣'
      RETURN 1009
    END

    -- ��������
    BEGIN TRAN

      -- д��ת����¼
      INSERT ReturnAwardGrant (SourceUserID,TargetUserID,TradeType,SourceBefore,TargetBefore,Amount,ClientIP,CollectDate) 
      VALUES (@UserID,@TargetUserID,@dwAwardType,@GiveBefore,@ReceiveBefore,@dwAward,@strClientIP,@DateTime)

      -- д������ˮ��¼ ת���� TypeID=10 ����ת��
      INSERT INTO WHQJRecordDB.DBO.RecordTreasureSerial
      (SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
      VALUES(dbo.WF_GetSerialNumber(), 0, @UserID, 10, @GiveBefore, @GiveBeforeInsure, -@dwAward, @strClientIP, @DateTime)
      -- д������ˮ��¼ ת�뷽 TypeID=11 ������ת��
      INSERT INTO WHQJRecordDB.DBO.RecordTreasureSerial
      (SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
      VALUES(dbo.WF_GetSerialNumber(), 0, @TargetUserID, 10, @ReceiveBefore, @ReceiveBeforeInsure, @dwAward, @strClientIP, @DateTime)


      -- ���´����û��������
      UPDATE WHQJTreasureDB.DBO.GameScoreInfo SET Score = Score - @dwAward WHERE UserID = @UserID
      -- ���±�ת���û��������
      UPDATE WHQJTreasureDB.DBO.GameScoreInfo  SET Score = Score + @dwAward WHERE UserID = @TargetUserID

      IF @@Error > 0 
      BEGIN
        ROLLBACK TRAN
        RETURN 2003
      END

    COMMIT TRAN

  END
  ELSE 
  BEGIN
    SET @strErrorDescribe = N'��Ǹ��ת����������ȷ��'
    RETURN 1000
  END

  RETURN 0
END
GO