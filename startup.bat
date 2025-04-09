@echo off
REM 设置控制台代码页为 UTF-8
chcp 65001 >nul
setlocal enabledelayedexpansion
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
set /p "gamePath=请输入苏丹的游戏路径（例如：E:\Games\Steam\steamapps\common\Sultan's Game）："
REM 检查路径是否存在（添加双引号避免空格问题）
if exist "%gamePath%\" (
    echo 游戏路径存在，开始执行文件替换操作.
    REM === 1. 替换卡牌和商店配置 ===
    REM 构造目标路径（确保双引号包裹）
    set "dataPath=%gamePath%\Sultan's Game_Data\StreamingAssets\config"
    echo 数据路径："!dataPath!"

    REM 复制文件（显式指定目标路径）
    copy /y "%~dp0cards.json" "!dataPath!\cards.json" >nul
    copy /y "%~dp0upgrade.json" "!dataPath!\upgrade.json" >nul
    echo 卡牌和商店配置已更新.
    REM === 2. 添加仪式文件 ===
    set "ceremonyPath=%gamePath%\Sultan's Game_Data\StreamingAssets\config\rite"
    for %%f in ("%~dp0rite\*.json") do (
        set "fileName=%%~nxf"
        echo 正在添加仪式："!fileName!"
        copy /y "%%f" "!ceremonyPath!\!fileName!" >nul
        if errorlevel 1 (
            echo [错误] 仪式文件复制失败: "%%f"
            exit /b 1
        )
    )
    REM === 3. 添加事件、道具和装备文件 ===
    set "eventPath=%gamePath%\Sultan's Game_Data\StreamingAssets\config\event"
    REM 复制事件文件
    for %%f in ("%~dp0event\*.json") do (
        set "fileName=%%~nxf"
        echo 正在添加事件："!fileName!"
        copy /y "%%f" "!eventPath!\!fileName!" >nul
        if errorlevel 1 (
            echo [错误] 事件文件复制失败: "%%f"
            exit /b 1
        )
    )
    REM 复制道具文件（确保目标子目录存在）
    set "itemsPath=!eventPath!"
    for %%f in ("%~dp0event\items\*.json") do (
        set "fileName=%%~nxf"
        echo 正在添加道具："!fileName!"
        copy /y "%%f" "!itemsPath!\!fileName!" >nul
        if errorlevel 1 (
            echo [错误] 道具文件复制失败: "%%f"
            exit /b 1
        )
    )

    set "equipsPath=!eventPath!"
    for %%f in ("%~dp0event\equips\*.json") do (
        set "fileName=%%~nxf"
        echo 正在添加装备："!fileName!"
        copy /y "%%f" "!equipsPath!\!fileName!" >nul
        if errorlevel 1 (
            echo [错误] 装备文件复制失败: "%%f"
            exit /b 1
        )
    )
    echo 所有文件已成功复制到 E 盘游戏目录！
    timeout /t 5 >nul
) else (
    echo 游戏路径不存在，请检查输入的路径是否正确："%gamePath%"
)
endlocal