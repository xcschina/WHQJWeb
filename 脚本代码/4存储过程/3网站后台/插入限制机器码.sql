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

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_BatchInsertConfineMachine]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_BatchInsertConfineMachine]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PM_BatchInsertConfineMachine]
(
	@strMachineList			VARCHAR(3300)				--�������б�
)
			
WITH ENCRYPTION AS

BEGIN
	-- ��������
	SET NOCOUNT ON
	
	DECLARE @I INT
	DECLARE @MaxID INT
	DECLARE @CurrentMachine NVARCHAR(32)
	 
	-- ������ʱ��
	SELECT * INTO #tmpTable FROM WF_Split(@strMachineList,',')
	SELECT @MaxID=ISNULL(MAX(id),0) FROM #tmpTable
	SET @I=1

	-- ѭ������
	WHILE @I<@MaxID OR @I=@MaxID
	BEGIN
		SELECT @CurrentMachine=rs FROM #tmpTable WHERE id=@I
		IF NOT EXISTS(SELECT MachineSerial FROM ConfineMachine WHERE MachineSerial=@CurrentMachine)
		BEGIN
			INSERT INTO ConfineMachine(MachineSerial,EnjoinLogon,EnjoinRegister)
			VALUES(@CurrentMachine,1,1)
		END
		ELSE
		BEGIN
			UPDATE ConfineMachine SET EnjoinLogon=1,EnjoinRegister=1,EnjoinOverDate=NULL
			WHERE MachineSerial=@CurrentMachine
		END
		
		SET @I=@I+1
	END
	
	-- ɾ����ʱ��
	DROP TABLE #tmpTable
	RETURN 0;
END
GO