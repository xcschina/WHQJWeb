----------------------------------------------------------------------------------------------------
-- ��Ȩ��2011
-- ʱ�䣺2012-02-23
-- ��;��������ʯ��ѯ
----------------------------------------------------------------------------------------------------

USE WHQJRecordDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_QueryAgentDiamond') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_QueryAgentDiamond
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE NET_PW_QueryAgentDiamond
	@dwUserID	INT						-- �û� I D
WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- �û���Ϣ
DECLARE @Diamond BIGINT
DECLARE @InDiamond BIGINT
DECLARE @OutDiamond BIGINT
DECLARE @AgentDiamond BIGINT
DECLARE @UserDiamond BIGINT

-- ִ���߼�
BEGIN
	-- ��ѯ������ʯ
	SELECT @Diamond=Diamond FROM WHQJTreasureDB.dbo.UserCurrency WHERE UserID = @dwUserID
	
	--��ѯת����ʯ��
	SELECT @InDiamond=ISNULL(SUM(PresentDiamond),0) FROM RecordPresentCurrency WITH(NOLOCK) WHERE TargetUserID = @dwUserID

	--��ѯת����ʯ��
	SELECT @OutDiamond=ISNULL(SUM(PresentDiamond),0) FROM RecordPresentCurrency WITH(NOLOCK) WHERE SourceUserID = @dwUserID

	--��ѯ�����¼���������
	SELECT @AgentDiamond=ISNULL(SUM(PresentDiamond),0) FROM RecordPresentCurrency WITH(NOLOCK) WHERE SourceUserID = @dwUserID AND TargetAgentLevel>0

	--��ѯ�����¼��������
	SELECT @UserDiamond=ISNULL(SUM(PresentDiamond),0) FROM RecordPresentCurrency WITH(NOLOCK) WHERE SourceUserID = @dwUserID AND TargetAgentLevel=0
	
	--�����ѯֵ
	SELECT @Diamond AS Diamond,@InDiamond AS InDiamond,@OutDiamond AS OutDiamond,@AgentDiamond AS AgentDiamond,@UserDiamond AS UserDiamond

END

RETURN 0

GO