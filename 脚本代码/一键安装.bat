@echo  off

TITLE 网狐棋牌旗舰版数据库网站部分 自动安装中...请注意：安装过程中请勿关闭
COLOR 09
CLS
md D:\数据库\旗舰平台

set rootPath=1数据库脚本\
osql -E -i "%rootPath%1数据库库创建.sql"
osql -E -i "%rootPath%2数据库表创建.sql"
osql -E -i "%rootPath%3数据库库链接.sql"

set rootPath=2数据库数据\
osql -E -i "%rootPath%初始化配置.sql"
osql -E -i "%rootPath%网站后台数据.sql"

set rootPath=3数据库修改\
osql -E -i "%rootPath%更新脚本.sql"

set rootPath=代理系统\
osql -E -i "%rootPath%1数据库创建.sql"
osql -E -i "%rootPath%2数据库表结构.sql"
osql -E -i "%rootPath%3数据库表数据.sql"

set rootPath=代理系统\4存储过程\
osql -d WHQJAccountsDB -E  -n -i "%rootPath%(公共)代理商关系查询.sql"
osql -d WHQJGameScoreDB -E  -n -i "%rootPath%(公共)代理商关系查询.sql"
osql -d WHQJNativeWebDB -E  -n -i "%rootPath%(公共)代理商关系查询.sql"
osql -d WHQJPlatformDB -E  -n -i "%rootPath%(公共)代理商关系查询.sql"
osql -d WHQJPlatformManagerDB -E  -n -i "%rootPath%(公共)代理商关系查询.sql"
osql -d WHQJRecordDB -E  -n -i "%rootPath%(公共)代理商关系查询.sql"
osql -d WHQJTreasureDB -E  -n -i "%rootPath%(公共)代理商关系查询.sql"
osql -d WHQJAgentDB -E  -n -i "%rootPath%(公共)代理商关系查询.sql"
osql -d WHQJGroupDB -E  -n -i "%rootPath%(公共)代理商关系查询.sql"

osql -E -i "%rootPath%(代理)代理商创建代理.sql"
osql -E -i "%rootPath%(代理)代理登录.sql"
osql -E -i "%rootPath%(代理)转赠返利.sql"
osql -E -i "%rootPath%(代理)领取返利.sql"
osql -E -i "%rootPath%(公共)玩家绑定代理.sql"
osql -E -i "%rootPath%(公共)系统返利.sql"
osql -E -i "%rootPath%(后台)系统创建代理.sql"

set rootPath=4存储过程\1公共过程\
osql -d WHQJAccountsDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJGameScoreDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJNativeWebDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJPlatformDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJPlatformManagerDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJRecordDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJTreasureDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJAgentDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJGroupDB -E  -n -i "%rootPath%分页过程.sql"

osql -d WHQJAccountsDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJGameScoreDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJNativeWebDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJPlatformDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJPlatformManagerDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJRecordDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJTreasureDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJAgentDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJGroupDB -E  -n -i "%rootPath%切字符串.sql"

osql -d WHQJAccountsDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJGameScoreDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJNativeWebDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJPlatformDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJPlatformManagerDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJRecordDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJTreasureDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJAgentDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJGroupDB -E  -n -i "%rootPath%切字符串.sql"

set rootPath=4存储过程\2网站前台\
osql -E -i "%rootPath%在线充值.sql"
osql -E -i "%rootPath%在线苹果充值.sql"
osql -E -i "%rootPath%在线订单.sql"
osql -E -i "%rootPath%手机充值产品.sql"
osql -E -i "%rootPath%手机登录成功数据.sql"
osql -E -i "%rootPath%手机登录数据.sql"
osql -E -i "%rootPath%手机获取游戏数据.sql"
osql -E -i "%rootPath%用户注册微信.sql"
osql -E -i "%rootPath%获取排行版数据.sql"
osql -E -i "%rootPath%领取排行榜奖励.sql"
osql -E -i "%rootPath%领取推广好友奖励.sql"
osql -E -i "%rootPath%领取注册赠送奖励.sql"
osql -E -i "%rootPath%钻石兑换金币.sql"
osql -E -i "%rootPath%领取推广返利奖励.sql"
osql -E -i "%rootPath%用户代理中心.sql"
osql -E -i "%rootPath%充值处理.sql"

set rootPath=4存储过程\3网站后台\
osql -E -i "%rootPath%菜单加载.sql"
osql -E -i "%rootPath%插入限制IP.sql"
osql -E -i "%rootPath%插入限制机器码.sql"
osql -E -i "%rootPath%管理员登录.sql"
osql -E -i "%rootPath%权限加载.sql"
osql -E -i "%rootPath%注册IP统计.sql"
osql -E -i "%rootPath%注册机器码统计.sql"
osql -E -i "%rootPath%代理钻石查询.sql"
osql -E -i "%rootPath%后台赠送钻石.sql"
osql -E -i "%rootPath%赠送靓号.sql"
osql -E -i "%rootPath%获取代理商下线.sql"
osql -E -i "%rootPath%系统创建代理.sql"
osql -E -i "%rootPath%后台赠送金币.sql"
osql -E -i "%rootPath%金币分布.sql"
osql -E -i "%rootPath%钻石分布.sql"
osql -E -i "%rootPath%数据汇总.sql"
osql -E -i "%rootPath%创建超端管理员.sql"

set rootPath=4存储过程\5作业脚本\
osql -E -i "%rootPath%排行榜统计.sql"
osql -E -i "%rootPath%排行榜周统计.sql"
osql -E -i "%rootPath%每日钻石统计.sql"
osql -E -i "%rootPath%每日统计.sql"

set rootPath=5创建作业\
osql -E -i "%rootPath%排行榜统计.sql"
osql -E -i "%rootPath%排行榜周统计.sql"
osql -E -i "%rootPath%每日钻石统计.sql"
osql -E -i "%rootPath%每日统计.sql"

pause

COLOR 0A
CLS
@echo off
CLS
echo ------------------------------
echo.
echo. 数据库建立完成
echo.
echo ------------------------------

pause
