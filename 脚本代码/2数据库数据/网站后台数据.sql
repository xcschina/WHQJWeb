USE WHQJPlatformManagerDB

-- ģ���
TRUNCATE TABLE [dbo].[Base_Module]

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (1, 0, N'�û�ϵͳ', N'', 1, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (2, 0, N'��ֵϵͳ', N'', 2, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (3, 0, N'ά��ϵͳ', N'', 3, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (4, 0, N'��վϵͳ', N'', 4, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (5, 0, N'���ϵͳ', N'', 5, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (6, 0, N'��ʯϵͳ', N'', 6, 0, 1, N'',0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (7, 0, N'ͳ��ϵͳ', N'', 7, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (8, 0, N'��̨ϵͳ', N'', 8, 0, 1, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (100, 1, N'�û�����', N'/Module/AccountManager/AccountsList.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom])
                    VALUES (101, 1, N'����������', N'/Module/AccountManager/UserPlaying.aspx', 0, 0, 2, N'', 0)
-- INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (102, 1, N'���ƹ���', N'/Module/AccountManager/ConfineAddressList.aspx', 0, 0, 4, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (103, 1, N'�������', N'/Module/AgentManager/AgentUserList.aspx', 0, 0, 1, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (200, 2, N'��ֵ����', N'/Module/FilledManager/AppPayConfigList.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (201, 2, N'��ֵ��¼', N'/Module/FilledManager/RecordPayDiamond.aspx', 0, 0, 2, N'', 0)

-- INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (300, 3, N'��������', N'/Module/AppManager/DataBaseInfoList.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (301, 3, N'��Ϸ����', N'/Module/AppManager/GameGameItemList.aspx', 0, 0, 2, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (302, 3, N'ϵͳ��Ϣ', N'/Module/AppManager/SystemMessageList.aspx', 0, 0, 3, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (303, 3, N'ϵͳ����', N'/Module/AppManager/SystemSet.aspx', 0, 0, 4, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (304, 3, N'�ƹ����', N'/Module/AppManager/SpreadConfigList.aspx', 0, 0, 5, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (305, 3, N'���й���', N'/Module/AppManager/RankingConfigList.aspx', 0, 0, 6, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (400, 4, N'վ������', N'/Module/WebManager/LogoSet.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (401, 4, N'��Ϸ����', N'/Module/WebManager/KindRuleList.aspx', 0, 0, 2, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (402, 4, N'������', N'/Module/WebManager/AdsList.aspx', 0, 0, 3, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (403, 4, N'���Ź���', N'/Module/WebManager/SystemNoticeList.aspx', 0, 0, 4, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (404, 4, N'��Ϣ����', N'/Module/WebManager/UMessagePushList.aspx', 0, 0, 5, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (500, 5, N'��ҹ���', N'/Module/GoldManager/AccountsGoldList.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (501, 5, N'�һ�����', N'/Module/GoldManager/GoldExchConfigList.aspx', 0, 0, 2, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (502, 5, N'�һ���¼', N'/Module/GoldManager/RecordGoldExch.aspx', 0, 0, 3, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (503, 5, N'���м�¼', N'/Module/GoldManager/RecordBankTrade.aspx', 0, 0, 4, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (504, 5, N'������¼', N'/Module/GoldManager/RecordGameInOut.aspx', 0, 0, 5, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (505, 5, N'��Ϸ��¼', N'/Module/GoldManager/RecordUserGame.aspx', 0, 0, 6, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (600, 6, N'�û���ʯ����', N'/Module/Diamond/DiamondList.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (601, 6, N'�������ȼ�¼', N'/Module/Diamond/RecordBuyHorn.aspx', 0, 0, 2, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (602, 6, N'���ͽ��׼�¼', N'/Module/Diamond/RecordPresentTrade.aspx', 0, 0, 3, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (603, 6, N'��̨���ͼ�¼', N'/Module/Diamond/RecordSysPresent.aspx', 0, 0, 4, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (604, 6, N'��ʯ������¼', N'/Module/Diamond/RecordOpenRoom.aspx', 0, 0, 5, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (605, 6, N'�һ���Ҽ�¼', N'/Module/Diamond/RecordDiamondExch.aspx', 0, 0, 6, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (700, 7, N'�û�ע��ͳ��', N'/Module/DataStatistics/UserRegister.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (701, 7, N'�û�����ͳ��', N'/Module/DataStatistics/UserOnline.aspx', 0, 0, 2, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (702, 7, N'�û���ʯͳ��', N'/Module/Diamond/StatisticsDiamond.aspx', 0, 0, 3, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (703, 7, N'ÿ��˰��ͳ��', N'/Module/DataStatistics/DailyRevenue.aspx', 0, 0, 4, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (704, 7, N'ÿ�����ͳ��', N'/Module/DataStatistics/DailyWaste.aspx', 0, 0, 5, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (705, 7, N'�Ƹ��ֲ�ͳ��', N'/Module/DataStatistics/WealthDistribute.aspx', 0, 0, 6, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (706, 7, N'ϵͳȫ��ͳ��', N'/Module/DataStatistics/SystemStat.aspx', 0, 0, 0, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (800, 8, N'�˺Ź���', N'/Module/BackManager/BaseRoleList.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (801, 8, N'��ȫ��־', N'/Module/OperationLog/SystemSecurityList.aspx', 0, 0, 2, N'', 0)




-- ģ��Ȩ�ޱ�
TRUNCATE TABLE Base_ModulePermission

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (100, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (100, N'�༭', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (100, N'��������', 256, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (100, N'��/��', 8192, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (100, N'����Ȩ��/ȡ��Ȩ��', 524288, 0, 0, 1)

-- INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (102, N'�鿴', 1, 0, 0, 1)
-- INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (102, N'���', 2, 0, 0, 1)
-- INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (102, N'�༭', 4, 0, 0, 1)
-- INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (102, N'ɾ��', 8, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (103, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (103, N'���', 2, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (103, N'�༭', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (103, N'��/��', 8192, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (103, N'������ʯ', 262144, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (200, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (200, N'���', 2, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (200, N'�༭', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (200, N'ɾ��', 8, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (201, N'�鿴', 1, 0, 0, 1)

-- INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (300, N'�鿴', 1, 0, 0, 1)
-- INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (300, N'���', 2, 0, 0, 1)
-- INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (300, N'�༭', 4, 0, 0, 1)
-- INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (300, N'ɾ��', 8, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (301, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (301, N'���', 2, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (301, N'�༭', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (301, N'ɾ��', 8, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (302, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (302, N'���', 2, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (302, N'�༭', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (302, N'ɾ��', 8, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (302, N'��/��', 8192, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (303, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (303, N'�༭', 4, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (304, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (304, N'���', 2, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (304, N'�༭', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (304, N'ɾ��', 8, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (305, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (305, N'���', 2, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (305, N'�༭', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (305, N'ɾ��', 8, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (400, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (400, N'�༭', 4, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (401, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (401, N'���', 2, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (401, N'�༭', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (401, N'ɾ��', 8, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (401, N'��/��', 8192, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (402, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (402, N'���', 2, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (402, N'�༭', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (402, N'ɾ��', 8, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (403, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (403, N'���', 2, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (403, N'�༭', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (403, N'ɾ��', 8, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (404, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (404, N'�༭', 4, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (500, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (500, N'���ͽ��', 32, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (501, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (502, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (503, N'�鿴', 1, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (504, N'�鿴', 1, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (505, N'�鿴', 1, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (600, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (600, N'������ʯ', 262144, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (601, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (602, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (603, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (604, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (605, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (606, N'�鿴', 1, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (700, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (701, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (702, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (703, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (704, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (705, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (706, N'�鿴', 1, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (800, N'�鿴', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (800, N'���', 2, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (800, N'�༭', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (800, N'ɾ��', 8, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (800, N'��/��', 8192, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (801, N'�鿴', 1, 0, 0, 1)

-- �û���
TRUNCATE TABLE Base_Users

INSERT INTO Base_Users(Username,Password,RoleID) VALUES('admin','E10ADC3949BA59ABBE56E057F20F883E',1)

-- ��ɫ��
TRUNCATE TABLE Base_Roles

INSERT INTO Base_Roles(RoleName,Description) VALUES('��������Ա','��������Ա')


