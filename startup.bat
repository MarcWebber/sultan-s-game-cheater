@echo off
REM 设置控制台代码页为 UTF-8
chcp 65001 >nul
REM 检查git命令是否可用
where git >nul 2>&1
@REM if %errorlevel% equ 0 (
@REM     echo Git 命令存在，开始执行 git pull 操作...
@REM     cd /d "%~dp0"
@REM     REM 拉取远程master分支
@REM     git pull origin master
@REM     if %errorlevel% equ 0 (
@REM         echo 成功拉取远程 master 分支。
@REM     ) else (
@REM         echo 拉取远程 master 分支时出错。
@REM     )
@REM ) else (
@REM     echo Git 命令不存在，跳过 git pull 操作。
@REM )

REM 接收用户输入：苏丹的游戏路径
set /p gamePath="请输入苏丹的游戏路径（例如：E:\Games\Steam\steamapps\common\Sultan's Game）："
REM 检查路径是否存在
if exist "%gamePath%" (
    echo 游戏路径存在，开始执行文件替换操作.
    REM 替换文件
    echo 正在替换卡牌以及命运商店
    set "dataPath=%gamePath%\Sultan's Game_Data\StreamingAssets\config"
    REM 将cards.json upgrade.json复制到目标路径
    copy /y "%~dp0cards.json" "%dataPath%\cards.json" >nul
    copy /y "%~dp0upgrade.json" "%dataPath%\upgrade.json" >nul

    echo 开始添加仪式
    set "ceremonyPath=%gamePath%\Sultan's Game_Data\StreamingAssets\rite"
    for %%f in ("%~dp0rite\*.json") do (
        set "fileName=%%~nxf"
        echo 正在添加仪式：!fileName!
        copy /y "%%f" "%ceremonyPath%\!fileName!" >nul
    )

    echo 开始添加事件
    set "eventPath=%gamePath%\Sultan's Game_Data\StreamingAssets\event"
    for %%f in ("%~dp0event\*.json") do (
        set "fileName=%%~nxf"
        echo 正在添加事件：!fileName!
        copy /y "%%f" "%eventPath%\!fileName!" >nul
    )

    for %%f in ("%~dp0event\items\*.json") do (
        set "fileName=%%~nxf"
        echo 正在添加道具：%fileName%
        copy /y "%%f" "%eventPath%\!fileName!" >nul
    )

    timeout /t 5 >nul

    for %%f in ("%~dp0event\equips\*.json") do (
        set "fileName=%%~nxf"
        echo 正在添加装备：%fileName%
        copy /y "%%f" "%eventPath%\!fileName!" >nul
    )
    timeout /t 5 >nul
) else (
    echo 游戏路径不存在，请检查路径是否正确。
)