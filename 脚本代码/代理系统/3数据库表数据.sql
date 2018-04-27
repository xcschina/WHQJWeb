USE WHQJPlatformManagerDB
GO

 -- ɾ���ɵĴ���������
DELETE DBO.Base_Module WHERE ModuleID = 103
-- �����µ�ģ��
DELETE DBO.Base_Module WHERE ModuleID = 10 OR ParentID = 10
INSERT DBO.Base_Module (ModuleID,ParentID,Title,Link,OrderNo,Nullity,IsMenu,[Description],ManagerPopedom)
VALUES (10,0,N'����ϵͳ',N'',10,0,1,N'',0)
INSERT DBO.Base_Module (ModuleID,ParentID,Title,Link,OrderNo,Nullity,IsMenu,[Description],ManagerPopedom)
VALUES (1000,10,N'ϵͳ����',N'/Module/AgentManager/SystemSet.aspx',1,0,0,N'',0)
INSERT DBO.Base_Module (ModuleID,ParentID,Title,Link,OrderNo,Nullity,IsMenu,[Description],ManagerPopedom)
VALUES (1001,10,N'�������',N'/Module/AgentManager/AgentList.aspx',2,0,0,N'',0)
INSERT DBO.Base_Module (ModuleID,ParentID,Title,Link,OrderNo,Nullity,IsMenu,[Description],ManagerPopedom)
VALUES (1002,10,N'������',N'/Module/AgentManager/AgentReturnConfigList.aspx',3,0,0,N'',0)
GO

-- ������ģ���Ȩ��
DELETE DBO.Base_ModulePermission WHERE ModuleID IN (1000,1001)
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (1000,N'�鿴',1,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (1000,N'�޸�',2,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (1001,N'�鿴',1,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (1001,N'����',2,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (1001,N'�޸�',4,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (1001,N'����',8,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (1002,N'�鿴',1,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (1002,N'����',2,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (1002,N'�޸�',4,0,0,1)
GO
INSERT INTO DBO.Base_ModulePermission ([ModuleID] ,[PermissionTitle] ,[PermissionValue] ,[Nullity] ,[StateFlag] ,[ParentID])
VALUES (1002,N'ɾ��',8,0,0,1)
GO

USE WHQJAgentDB
GO

/** ����ϵͳ-ϵͳ����-������ S **/
TRUNCATE TABLE DBO.SystemStatusInfo
INSERT SystemStatusInfo ([StatusName],[StatusValue],[StatusString],[StatusTip],[StatusDescription],[SortID])
VALUES (N'AgentAwardType',3,'������ģʽ','����ģʽ','��ֵ��1��������ų�ֵ��������ʯ����2�����������Ϸ˰�շ�������ҡ���3����ͬʱ����1��2���ַ���ģʽ',10)
GO
INSERT SystemStatusInfo ([StatusName],[StatusValue],[StatusString],[StatusTip],[StatusDescription],[SortID])
VALUES (N'ReceiveDiamondSave',100,'��ȡ��ʯ����','��ȡ��ʯ����','��ֵ��0������ȡ��ʯʱ�ޱ���������0����ÿ����ȡ��ʯ���ɴ��ڿ���ȡֵ-����ֵ',50)
GO
INSERT SystemStatusInfo ([StatusName],[StatusValue],[StatusString],[StatusTip],[StatusDescription],[SortID])
VALUES (N'ReceiveGoldSave',10000,'��ȡ��ұ���','��ȡ��ұ���','��ֵ��0������ȡ���ʱ�ޱ���������0����ÿ����ȡ��Ҳ��ɴ��ڿ���ȡֵ-����ֵ',51)
GO
/** ����ϵͳ-ϵͳ����-������ E **/

/** ����ϵͳ-��������-������ S **/
TRUNCATE TABLE DBO.ReturnAwardConfig
INSERT ReturnAwardConfig(AwardType,AwardLevel,AwardScale,Nullity) 
VALUES (1,1,0.35,0)
GO
INSERT ReturnAwardConfig(AwardType,AwardLevel,AwardScale,Nullity) 
VALUES (1,2,0.07,0)
GO
INSERT ReturnAwardConfig(AwardType,AwardLevel,AwardScale,Nullity) 
VALUES (1,3,0.03,0)
GO
INSERT ReturnAwardConfig(AwardType,AwardLevel,AwardScale,Nullity) 
VALUES (2,1,0.35,0)
GO
INSERT ReturnAwardConfig(AwardType,AwardLevel,AwardScale,Nullity) 
VALUES (2,2,0.07,0)
GO
INSERT ReturnAwardConfig(AwardType,AwardLevel,AwardScale,Nullity) 
VALUES (2,3,0.03,0)
GO
/** ����ϵͳ-��������-������ E **/

