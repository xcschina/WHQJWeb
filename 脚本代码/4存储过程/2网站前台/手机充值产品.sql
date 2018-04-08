----------------------------------------------------------------------------------------------------
-- ��Ȩ��2011
-- ʱ�䣺2012-02-23
-- ��;���ֻ��˻�ȡ��ֵ��Ʒ
----------------------------------------------------------------------------------------------------

USE WHQJTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_GetMobilePayConfig') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_GetMobilePayConfig
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE NET_PW_GetMobilePayConfig
	@dwUserID INT,
	@PayType INT
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

DECLARE @NowTime NVARCHAR(20)
DECLARE @StartTime NVARCHAR(20)
DECLARE @EndTime NVARCHAR(20)

-- ִ���߼�
BEGIN
	-- ��ȡ��ѯʱ��
	SET @NowTime = CONVERT(VARCHAR(10),GETDATE(),120) 
	SET @StartTime = @NowTime + N' 00:00:00'
	SET @EndTime = @NowTime + N' 23:59:59'

	-- ��ȡ�׳�
	SELECT OnLineID FROM OnLinePayOrder WITH(NOLOCK) WHERE UserID=@dwUserID AND OrderStatus=1 AND OrderDate BETWEEN @StartTime AND @EndTime

	-- ��ȡ��ֵ��Ʒ
	SELECT ConfigID,AppleID,PayName,PayType,PayPrice,PayIdentity,ImageType,SortID,Diamond,PresentDiamond FROM AppPayConfig WITH(NOLOCK) WHERE PayType = @PayType ORDER BY PayIdentity DESC,SortID ASC

	-- ��ȡ�һ���Ʒ
	SELECT ConfigID,ConfigName,Diamond,ExchGold,ImageType,SortID,ConfigTime FROM CurrencyExchConfig WITH(NOLOCK) ORDER BY SortID ASC

END

RETURN 0

GO