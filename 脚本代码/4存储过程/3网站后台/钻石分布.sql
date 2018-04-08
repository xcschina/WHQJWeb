----------------------------------------------------------------------------------------------------
-- ��Ȩ��2011
-- ʱ�䣺2012-02-23
-- ��;����̨��ѯ��ʯ�ֲ�
----------------------------------------------------------------------------------------------------

USE WHQJTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_GetDiamondDistribute') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_GetDiamondDistribute
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE NET_PW_GetDiamondDistribute

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	-- ��ȡ��ʯ�ֲ�
	SELECT '1������' AS name, COUNT(UserID) AS value FROM UserCurrency WITH(NOLOCK) WHERE Diamond<100 UNION ALL 
	SELECT '1��~3��' AS name, COUNT(UserID) AS value FROM UserCurrency WITH(NOLOCK) WHERE Diamond>=100 AND Diamond<300 UNION ALL 
	SELECT '3��~5��' AS name, COUNT(UserID) AS value FROM UserCurrency WITH(NOLOCK) WHERE Diamond>=300 AND Diamond<500 UNION ALL 
	SELECT '5��~1ǧ' AS name, COUNT(UserID) AS value FROM UserCurrency WITH(NOLOCK) WHERE Diamond>=500 AND Diamond<1000 UNION ALL 
	SELECT '1ǧ~5ǧ' AS name, COUNT(UserID) AS value FROM UserCurrency WITH(NOLOCK) WHERE Diamond>=1000 AND Diamond<5000 UNION ALL 
	SELECT '5ǧ����' AS name, COUNT(UserID) AS value FROM UserCurrency WITH(NOLOCK) WHERE Diamond>=5000

	-- ��ȡ��ʯ����
	SELECT ISNULL(SUM(Diamond),0) AS Diamond FROM UserCurrency WITH(NOLOCK)

END

RETURN 0

GO
