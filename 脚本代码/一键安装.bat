@echo  off

TITLE ���������콢�����ݿ���վ���� �Զ���װ��...��ע�⣺��װ����������ر�
COLOR 09
CLS
md D:\���ݿ�\�콢ƽ̨

set rootPath=1���ݿ�ű�\
osql -E -i "%rootPath%1���ݿ�ⴴ��.sql"
osql -E -i "%rootPath%2���ݿ����.sql"
osql -E -i "%rootPath%3���ݿ������.sql"

set rootPath=2���ݿ�����\
osql -E -i "%rootPath%��ʼ������.sql"
osql -E -i "%rootPath%��վ��̨����.sql"

set rootPath=3���ݿ��޸�\
osql -E -i "%rootPath%���½ű�.sql"

set rootPath=4�洢����\1��������\
osql -d WHQJAccountsDB -E  -n -i "%rootPath%��ҳ����.sql"
osql -d WHQJGameScoreDB -E  -n -i "%rootPath%��ҳ����.sql"
osql -d WHQJNativeWebDB -E  -n -i "%rootPath%��ҳ����.sql"
osql -d WHQJPlatformDB -E  -n -i "%rootPath%��ҳ����.sql"
osql -d WHQJPlatformManagerDB -E  -n -i "%rootPath%��ҳ����.sql"
osql -d WHQJRecordDB -E  -n -i "%rootPath%��ҳ����.sql"
osql -d WHQJTreasureDB -E  -n -i "%rootPath%��ҳ����.sql"
osql -d WHQJAccountsDB -E  -n -i "%rootPath%���ַ���.sql"
osql -d WHQJGameScoreDB -E  -n -i "%rootPath%���ַ���.sql"
osql -d WHQJNativeWebDB -E  -n -i "%rootPath%���ַ���.sql"
osql -d WHQJPlatformDB -E  -n -i "%rootPath%���ַ���.sql"
osql -d WHQJPlatformManagerDB -E  -n -i "%rootPath%���ַ���.sql"
osql -d WHQJRecordDB -E  -n -i "%rootPath%���ַ���.sql"
osql -d WHQJTreasureDB -E  -n -i "%rootPath%���ַ���.sql"

osql -d WHQJAccountsDB -E  -n -i "%rootPath%������ˮ��.sql"
osql -d WHQJGameScoreDB -E  -n -i "%rootPath%������ˮ��.sql"
osql -d WHQJNativeWebDB -E  -n -i "%rootPath%������ˮ��.sql"
osql -d WHQJPlatformDB -E  -n -i "%rootPath%������ˮ��.sql"
osql -d WHQJPlatformManagerDB -E  -n -i "%rootPath%������ˮ��.sql"
osql -d WHQJRecordDB -E  -n -i "%rootPath%������ˮ��.sql"
osql -d WHQJTreasureDB -E  -n -i "%rootPath%������ˮ��.sql"

set rootPath=4�洢����\2��վǰ̨\
osql -E -i "%rootPath%���߳�ֵ.sql"
osql -E -i "%rootPath%����ƻ����ֵ.sql"
osql -E -i "%rootPath%���߶���.sql"
osql -E -i "%rootPath%�ֻ���ֵ��Ʒ.sql"
osql -E -i "%rootPath%�ֻ���¼�ɹ�����.sql"
osql -E -i "%rootPath%�ֻ���¼����.sql"
osql -E -i "%rootPath%�ֻ���ȡ��Ϸ����.sql"
osql -E -i "%rootPath%�û�ע��΢��.sql"
osql -E -i "%rootPath%��ȡ���а�����.sql"
osql -E -i "%rootPath%��ȡ���а���.sql"
osql -E -i "%rootPath%��ȡ�ƹ���ѽ���.sql"
osql -E -i "%rootPath%��ȡע�����ͽ���.sql"
osql -E -i "%rootPath%��ʯ�һ����.sql"
osql -E -i "%rootPath%��ȡ�ƹ㷵������.sql"
osql -E -i "%rootPath%�û���������.sql"

set rootPath=4�洢����\3��վ��̨\
osql -E -i "%rootPath%�˵�����.sql"
osql -E -i "%rootPath%��������IP.sql"
osql -E -i "%rootPath%�������ƻ�����.sql"
osql -E -i "%rootPath%����Ա��¼.sql"
osql -E -i "%rootPath%Ȩ�޼���.sql"
osql -E -i "%rootPath%ע��IPͳ��.sql"
osql -E -i "%rootPath%ע�������ͳ��.sql"
osql -E -i "%rootPath%������ʯ��ѯ.sql"
osql -E -i "%rootPath%��̨������ʯ.sql"
osql -E -i "%rootPath%��������.sql"
osql -E -i "%rootPath%��ȡ����������.sql"
osql -E -i "%rootPath%ϵͳ��������.sql"
osql -E -i "%rootPath%��̨���ͽ��.sql"
osql -E -i "%rootPath%��ҷֲ�.sql"
osql -E -i "%rootPath%��ʯ�ֲ�.sql"
osql -E -i "%rootPath%���ݻ���.sql"
osql -E -i "%rootPath%�������˹���Ա.sql"

set rootPath=4�洢����\4�����̨\
osql -E -i "%rootPath%�����̨��¼.sql"
osql -E -i "%rootPath%�����̴�������.sql"
osql -E -i "%rootPath%������ʯ����.sql"
osql -E -i "%rootPath%�������������.sql"

set rootPath=4�洢����\5��ҵ�ű�\
osql -E -i "%rootPath%���а�ͳ��.sql"
osql -E -i "%rootPath%���а���ͳ��.sql"
osql -E -i "%rootPath%ÿ����ʯͳ��.sql"
osql -E -i "%rootPath%ÿ��ͳ��.sql"

set rootPath=5������ҵ\
osql -E -i "%rootPath%���а�ͳ��.sql"
osql -E -i "%rootPath%���а���ͳ��.sql"
osql -E -i "%rootPath%ÿ����ʯͳ��.sql"
osql -E -i "%rootPath%ÿ��ͳ��.sql"

pause

COLOR 0A
CLS
@echo off
CLS
echo ------------------------------
echo.
echo. ���ݿ⽨�����
echo.
echo ------------------------------

pause
