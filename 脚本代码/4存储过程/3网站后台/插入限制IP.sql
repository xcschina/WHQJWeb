----------------------------------------------------------------------
-- ʱ�䣺2011-09-29
-- ��;����̨����Ա����û���Ϣ
----------------------------------------------------------------------
USE WHQJAccountsDB
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_BatchInsertConfineAddress]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_BatchInsertConfineAddress]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PM_BatchInsertConfineAddress]
(
	@strIpList			VARCHAR(1600)				--IP�б�
)
			
WITH ENCRYPTION AS

BEGIN
	-- ��������
	SET NOCOUNT ON
	
	DECLARE @I INT
	DECLARE @MaxID INT
	DECLARE @CurrentIP NVARCHAR(15)
	 
	-- ������ʱ��
	SELECT * INTO #tmpTable FROM WF_Split(@strIpList,',')
	SELECT @MaxID=ISNULL(MAX(id),0) FROM #tmpTable
	SET @I=1

	-- ѭ������
	WHILE @I<@MaxID OR @I=@MaxID
	BEGIN
		SELECT @CurrentIP=rs FROM #tmpTable WHERE id=@I
		IF NOT EXISTS(SELECT AddrString FROM ConfineAddress WHERE AddrString=@CurrentIP)
		BEGIN
			INSERT INTO ConfineAddress(AddrString,EnjoinLogon,EnjoinRegister)
			VALUES(@CurrentIP,1,1)
		END
		ELSE
		BEGIN
			UPDATE ConfineAddress SET EnjoinLogon=1,EnjoinRegister=1,EnjoinOverDate=NULL
			WHERE AddrString=@CurrentIP
		END
		
		SET @I=@I+1
	END
	
	-- ɾ����ʱ��
	DROP TABLE #tmpTable
	RETURN 0;
END
GO