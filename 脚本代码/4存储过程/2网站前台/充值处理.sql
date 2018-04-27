----------------------------------------------------------------------
-- ��Ȩ��2018
-- ʱ�䣺2017-04-27
-- ��;����ֵ����
----------------------------------------------------------------------

USE [WHQJTreasureDB]
GO

-- ��ֵ����
IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PB_OperationOnLineOrder') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PB_OperationOnLineOrder
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---------------------------------------------------------------------------------------
-- ��ֵ����
CREATE PROCEDURE NET_PB_OperationOnLineOrder
	@strOrdersID		NVARCHAR(50),  --	������
	@strErrorDescribe	NVARCHAR(127) OUTPUT
--	�����Ϣ
WITH
	ENCRYPTION
AS

-- ��������
SET NOCOUNT ON

-- ������Ϣ
DECLARE @ConfigID INT
DECLARE @UserID INT
DECLARE @ScoreType TINYINT
DECLARE @Score INT
DECLARE @PresentScore INT
DECLARE @OtherPresent INT
DECLARE @OrderStatus TINYINT
DECLARE @OrderAddress NVARCHAR(15)

-- ִ���߼�
BEGIN
	-- ������ѯ
	SELECT @ConfigID=ConfigID,@UserID=UserID,@ScoreType=ScoreType, @Score=Score,@OrderAddress=OrderAddress, @OtherPresent=OtherPresent, @OrderStatus=OrderStatus
	FROM OnLinePayOrder WITH(NOLOCK)
	WHERE OrderID = @strOrdersID
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ����������!'
		RETURN 1001
	END
	IF @OrderStatus<>1
	BEGIN
		SET @strErrorDescribe=N'��Ǹ����ֵ����δ֧���������!'
		RETURN 1002
	END

	SELECT @PresentScore = PresentScore FROM AppPayConfig(NOLOCK) WHERE ConfigID = @ConfigID
	IF @PresentScore IS NULL SET @PresentScore = 0
  
	-- �˻��������׳�
	IF EXISTS(SELECT 1 FROM OnLinePayOrder WHERE UserID=@UserID AND ConfigID=@ConfigID AND OrderStatus>1)
	BEGIN
		SET @OtherPresent = @PresentScore
	END

	DECLARE @DateTime DateTime
	DECLARE @BeforeScore BIGINT
	set @DateTime = GETDATE()
	
	IF @OtherPresent >0
	BEGIN
		IF @ScoreType = 0
		BEGIN

			IF EXISTS(SELECT 1 FROM GameScoreLocker WHERE UserID=@UserID) 
			BEGIN
				SET @strErrorDescribe=N'��Ǹ����Ϸ�ҳ�ֵʱ���뿪��Ϸ����!'
				RETURN 1003
			END
			DECLARE @BeforeInsure BIGINT
			SELECT @BeforeScore = Score,@BeforeInsure = InsureScore FROM GameScoreInfo(NOLOCK) WHERE UserID = @UserID

			BEGIN TRAN
				-- �����û���ң�ֻ���Ӷ��ⲿ��
				UPDATE GameScoreInfo SET Score = Score + @OtherPresent WHERE UserID = @UserID

				-- д������ˮ��¼
				INSERT INTO RecordTreasureSerial
					(SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
				VALUES(dbo.WF_GetSerialNumber(), 0, @UserID, 14, @BeforeScore, @BeforeInsure, @OtherPresent, @OrderAddress, @DateTime)
			COMMIT TRAN
		END

		IF @ScoreType = 1
		BEGIN

			SELECT @BeforeScore = Diamond FROM UserCurrency(NOLOCK) WHERE UserID = @UserID

			BEGIN TRAN
				-- �����û���ˮ��ֻ���Ӷ��ⲿ��
				UPDATE UserCurrency SET Diamond = Diamond + @OtherPresent WHERE UserID = @UserID

				-- д����ʯ��ˮ��¼
				INSERT INTO WHQJRecordDB.dbo.RecordGoldSerial(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate) 
				VALUES(dbo.WF_GetSerialNumber(),0,@UserID,2,@BeforeScore,@OtherPresent,@OrderAddress,@DateTime)
			COMMIT TRAN
		END
	END

	-- ������ɺ�
	-- ���¶����� BeforeScore ����ScoreType �ֱ����ԭֵ 0:��Ϸ�� 1����ʯ 2.����
	UPDATE OnLinePayOrder SET OtherPresent=@OtherPresent,OrderStatus = 2,PayDate=GETDATE()  WHERE OrderID = @strOrdersID AND OrderStatus = 1

	-- ��ʯ��ֵ
	IF @ScoreType = 1
	BEGIN
		-- �ƹ��ֵ������������ڷ������ã�д�뷵����¼
		IF EXISTS (SELECT 1 FROM SpreadReturnConfig WHERE Nullity=0)
		BEGIN
			DECLARE @ReturnType TINYINT
			SELECT @ReturnType = StatusValue FROM WHQJAccountsDB.DBO.SystemStatusInfo WHERE StatusName = N'SpreadReturnType'
			IF @ReturnType IS NULL
			BEGIN
				SET @ReturnType = 0
			END
			INSERT WHQJRecordDB.DBO.RecordSpreadReturn (SourceUserID,TargetUserID,SourceDiamond,Spreadlevel,ReturnScale,ReturnNum,ReturnType,CollectDate)
			SELECT @UserID,A.UserID,@Score,B.SpreadLevel,B.PresentScale,@Score*B.PresentScale,@ReturnType,@DateTime FROM (SELECT UserID,LevelID FROM [dbo].[WF_GetAgentAboveAccounts](@UserID) ) AS A,SpreadReturnConfig AS B WHERE B.SpreadLevel=A.LevelID-1 AND A.LevelID>1 AND A.LevelID<=4 AND B.Nullity=0
		END

		-- ����ĳ�ֵ���� ����ģ��
		DECLARE @AgentAwardType INT
		SELECT @AgentAwardType = StatusValue FROM WHQJAgentDB.DBO.SystemStatusInfo WHERE StatusName = N'AgentAwardType'
		IF @AgentAwardType IS NOT NULL AND @AgentAwardType & 1 = 1
		BEGIN
			DECLARE @awardReturn INT
			EXEC @awardReturn = WHQJAgentDB.DBO.NET_PB_RecordAgentAward @UserID,@Score,1,@strOrdersID,@strErrorDescribe OUTPUT
		END
	END

END
RETURN 0
GO
