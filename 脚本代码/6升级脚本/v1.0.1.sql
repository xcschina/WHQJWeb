-- V1.0.1 ��������
USE WHQJAccountsDB
GO

IF EXISTS (SELECT 1 FROM DBO.SystemStatusInfo WHERE StatusName = N'MobileBattleRecordMask')
	DELETE DBO.SystemStatusInfo WHERE StatusName = N'MobileBattleRecordMask'
GO

INSERT INTO [dbo].[SystemStatusInfo] ([StatusName],[StatusValue],[StatusString],[StatusTip],[StatusDescription],[SortID])
     VALUES (N'MobileBattleRecordMask',7,N'�ֻ�����ս����ʾ����',N'����ս������',N'��ֵ��
	 1������ʾ��ͨ����ս����
	 2������ʾ��ҷ���ս����
	 3��1+2��
	 4������ʾ�����Ϸ��¼��
	 5��1+4��
	 6��2+4��
	 7��1+2+4��',50)
GO

USE WHQJGroupDB
GO


-- ���ֲ����ñ� ��ӱ����ֶΣ���̨�ã�
IF COL_LENGTH('IMGroupOption', 'OptionTip') IS NOT NULL  
BEGIN
  DECLARE @CONSTName VARCHAR(8000)
  SELECT @CONSTName=b.name FROM SYSCOLUMNS a,SYSOBJECTS b WHERE a.ID=OBJECT_ID('IMGroupOption') AND b.ID=a.CDEFAULT and a.NAME='OptionTip' and b.NAME like 'DF%'
  EXEC('ALTER TABLE IMGroupOption DROP CONSTRAINT '+@CONSTName)
  ALTER TABLE IMGroupOption DROP COLUMN OptionTip   
END
ALTER TABLE [dbo].[IMGroupOption] ADD OptionTip NVARCHAR(50) NOT NULL DEFAULT('')
GO

-- ���ֲ����ñ� ��������ֶ�
IF COL_LENGTH('IMGroupOption', 'SortID') IS NOT NULL  
BEGIN
  DECLARE @CONSTName VARCHAR(8000)
  SELECT @CONSTName=b.name FROM SYSCOLUMNS a,SYSOBJECTS b WHERE a.ID=OBJECT_ID('IMGroupOption') AND b.ID=a.CDEFAULT and a.NAME='SortID' and b.NAME like 'DF%'
  EXEC('ALTER TABLE IMGroupOption DROP CONSTRAINT '+@CONSTName)
  ALTER TABLE IMGroupOption DROP COLUMN SortID   
END
ALTER TABLE [dbo].[IMGroupOption] ADD SortID INT NOT NULL DEFAULT(0)

-- ���ֲ����� 
TRUNCATE TABLE [dbo].[IMGroupOption]
INSERT DBO.IMGroupOption(StationID,OptionName,OptionValue,OptionTip,OptionDescribe,SortID) 
VALUES(	0	,N'MaxMemberCount'	,	100, N'Ⱥ���������', N'����Ⱥ��������� ',100)
GO
INSERT DBO.IMGroupOption (StationID,OptionName,OptionValue,OptionTip,OptionDescribe,SortID)
VALUES (0,N'MaxCreateGroupCount',10, N'��������',N'��������ܴ���Ⱥ�����������÷�Χ1-10',101)
GO
INSERT DBO.IMGroupOption (StationID,OptionName,OptionValue,OptionTip,OptionDescribe,SortID)
VALUES (0,N'CreateGroupTakeIngot',0,N'��������',N'����Ⱥ���������0��û������ 1�����Ľ�� 2��������ʯ 3������û�������� 4������û���ʯ����',102)
GO
INSERT DBO.IMGroupOption (StationID,OptionName,OptionValue,OptionTip,OptionDescribe,SortID)
VALUES (0,N'CreateGroupDeductIngot',0, N'��������',N'�봴���������ʹ�ã����������������ò�Ϊ0ʱ�����Ļ��߼������ʯ�����������������ͬû����������ֵ��������',103)
GO
INSERT DBO.IMGroupOption (StationID,OptionName,OptionValue,OptionTip,OptionDescribe,SortID)
VALUES (0,N'MaxJoinGroupCount',10, N'��������',N'����������Ⱥ�����������÷�Χ1-10',104)
GO
INSERT DBO.IMGroupOption (StationID,OptionName,OptionValue,OptionTip,OptionDescribe,SortID)
VALUES (0,N'GroupPayType',3, N'֧������',N'����Լս����ʱ��˭֧����1������Ⱥ��֧�� 2���������֧�� 3����ʾͬʱ����Ⱥ��֧�������֧��',105)
GO
INSERT DBO.IMGroupOption (StationID,OptionName,OptionValue,OptionTip,OptionDescribe,SortID)
VALUES (0,N'GroupPayTypeChange',1, N'֧������',N'֧�������Ƿ�֧���޸ģ�0���������޸� 1�������޸�',106)
GO	
INSERT DBO.IMGroupOption (StationID,OptionName,OptionValue,OptionTip,OptionDescribe,SortID)
VALUES (0,N'GroupRoomType',3, N'������������',N'�趨��ҿ��Դ����ķ������ͣ�1��������ҷ��� 2���������ַ��� 3��ͬʱ������ҷ����ͻ��ַ���',107)
GO	

USE [WHQJPlatformManagerDB]
GO

  -- �����µ�ģ��
DELETE DBO.Base_Module WHERE ModuleID = 9 OR ParentID = 9
INSERT DBO.Base_Module (ModuleID,ParentID,Title,Link,OrderNo,Nullity,IsMenu,[Description],ManagerPopedom)
VALUES (9,0,N'���ֲ�ϵͳ',N'',9,0,1,N'',0)
INSERT DBO.Base_Module (ModuleID,ParentID,Title,Link,OrderNo,Nullity,IsMenu,[Description],ManagerPopedom)
VALUES (901,9,N'ϵͳ����',N'/Module/ClubManager/SystemSet.aspx',1,0,0,N'',0)
INSERT DBO.Base_Module (ModuleID,ParentID,Title,Link,OrderNo,Nullity,IsMenu,[Description],ManagerPopedom)
VALUES (902,9,N'���ֲ�����',N'/Module/ClubManager/GroupList.aspx',2,0,0,N'',0)
GO

  -- ������ģ���Ȩ��
DELETE DBO.Base_ModulePermission WHERE ModuleID IN (901,902)
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (901,N'�鿴',1,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (901,N'����',2,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (901,N'�޸�',4,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (901,N'ɾ��',8,0,0,1)
GO

INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (902,N'�鿴',1,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (902,N'����/�ⶳ',2,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (902,N'�ƽ�Ⱥ��',4,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (902,N'ǿ�ƽ�ɢ',8,0,0,1)
GO