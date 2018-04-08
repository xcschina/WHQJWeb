----------------------------------------------------------------------
-- ʱ�䣺2010-03-16
-- ��;��������ʯ
----------------------------------------------------------------------

USE WHQJTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[WSP_PM_GrantDiamond]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[WSP_PM_GrantDiamond]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO
----------------------------------------------------------------------

CREATE PROCEDURE WSP_PM_GrantDiamond
	@MasterID INT,				-- ����Ա��ʶ
	@ClientIP VARCHAR(15),		-- ���͵�ַ
	@UserID INT,				-- �û���ʶ
	@AddDiamond BIGINT,			-- ������ʯ
	@TypeID INT,				-- ��¼����
	@CollectNote NVARCHAR(32)	-- ���ͱ�ע	
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �û������Ϣ
DECLARE @CurDiamond BIGINT
DECLARE @Nullity TINYINT
DECLARE @DateTime DATETIME

-- ִ���߼�
BEGIN
	-- �û���֤
	SELECT @Nullity=Nullity FROM WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID = @UserID
	IF @Nullity IS NULL
	BEGIN
		RETURN 1001
	END
	IF @Nullity = 1
	BEGIN
		RETURN 1001
	END

	-- ��ȡ�û���ʯ
	SELECT @CurDiamond=Diamond FROM UserCurrency WHERE UserID = @UserID
	IF @CurDiamond IS NULL
	BEGIN
		SET @CurDiamond = 0
		INSERT INTO UserCurrency VALUES(@UserID,@AddDiamond)
	END
	ELSE
	BEGIN
		UPDATE UserCurrency SET Diamond = Diamond + @AddDiamond WHERE UserID=@UserID
	END

	SET @DateTime = GETDATE()
	INSERT INTO WHQJRecordDB.dbo.RecordGrantDiamond(MasterID,UserID,TypeID,CurDiamond,AddDiamond,ClientIP,CollectDate,CollectNote) 
	VALUES(@MasterID,@UserID,@TypeID,@CurDiamond,@AddDiamond,@ClientIP,@DateTime,@CollectNote)

	-- д����ʯ�仯��¼
	INSERT INTO WHQJRecordDB.dbo.RecordDiamondSerial(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate) 
	VALUES(dbo.WF_GetSerialNumber(),@MasterID,@UserID,0,@CurDiamond,@AddDiamond,@ClientIP,@DateTime)

END
RETURN 0

