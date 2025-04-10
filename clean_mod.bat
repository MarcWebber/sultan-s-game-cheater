@echo off
REM 设置控制台代码页为 UTF-8
chcp 65001 >nul
if errorlevel 1 (
                timeout /t 10 >nul
                echo the bat file may be incompatiable with your pc, please contact mod maker for information,  or you can copy files mannually
                exit /b 1
            )
            
setlocal enabledelayedexpansion

@REM REM 检查git命令是否可用
@REM where git >nul 2>&1
@REM @REM if %errorlevel% equ 0 (
@REM @REM     echo Git 命令存在，开始执行 git pull 操作...
@REM @REM     cd /d "%~dp0"
@REM @REM     REM 拉取远程master分支
@REM @REM     git pull origin master
@REM @REM     if %errorlevel% equ 0 (
@REM @REM         echo 成功拉取远程 master 分支。
@REM @REM     ) else (
@REM @REM         echo 拉取远程 master 分支时出错。
@REM @REM     )
@REM @REM ) else (
@REM @REM     echo Git 命令不存在，跳过 git pull 操作。
@REM @REM )

if errorlevel 1 (
                timeout /t 10 >nul
                echo the bat file may be incompatiable with your pc, please contact mod maker for information,  or you can copy files mannually
                exit /b 1
            )
set /p "gamePath=请输入苏丹的游戏路径（例如：E:\Games\Steam\steamapps\common\Sultan's Game）："
REM 检查路径是否存在（移除双引号避免空格问题）
if exist "%gamePath%\" (
    echo 游戏路径存在，开始执行文件替换操作.
    REM === 1. 替换卡牌和商店配置 ===
    REM 构造目标路径（确保双引号包裹）
    set "dataPath=%gamePath%\Sultan's Game_Data\StreamingAssets\config"
    echo 数据路径："!dataPath!"

    REM === 2. 移除仪式文件 ===
    set "ceremonyPath=%gamePath%\Sultan's Game_Data\StreamingAssets\config\rite"
    for %%f in ("%~dp0rite\*.json") do (
        set "fileName=%%~nxf"
        REM 清理旧文件
        if exist "!ceremonyPath!\!fileName!" (
            echo 正在删除旧仪式文件："!fileName!"
            del /q "!ceremonyPath!\!fileName!"
            if errorlevel 1 (
                timeout /t 10 >nul
                exit /b 1
            )
        )
    )

    REM === 移除额外的仪式（用于触发事件） ====
    for %%f in ("%~dp0rite\rites\*.json") do (
        set "fileName=%%~nxf"
        REM 清理旧文件
        if exist "!ceremonyPath!\!fileName!" (
            echo 正在删除旧仪式文件："!fileName!"
            del /q "!ceremonyPath!\!fileName!"
            if errorlevel 1 (
                echo [错误] 删除旧特殊仪式文件失败: "!ceremonyPath!\!fileName!"
                exit /b 1
            )
        )
    )

    REM === 3. 移除事件、道具和装备文件 ===
    set "eventPath=%gamePath%\Sultan's Game_Data\StreamingAssets\config\event"
    REM 复制事件文件
    for %%f in ("%~dp0event\*.json") do (
        set "fileName=%%~nxf"
        REM 清理旧文件
        if exist "!eventPath!\!fileName!" (
            echo 正在删除旧事件文件："!fileName!"
            del /q "!eventPath!\!fileName!"
            if errorlevel 1 (
                echo [错误] 删除旧事件文件失败: "!eventPath!\!fileName!"
                exit /b 1
            )
        )
    )
    REM 复制道具文件（确保目标子目录存在）
    set "itemsPath=!eventPath!"
    for %%f in ("%~dp0event\items\*.json") do (
        set "fileName=%%~nxf"
        REM 清理旧文件
        if exist "!itemsPath!\!fileName!" (
            del /q "!itemsPath!\!fileName!"
            if errorlevel 1 (
                echo [错误] 删除旧道具文件失败: "!itemsPath!\!fileName!"
                exit /b 1
            )
        )
    )

    set "equipsPath=!eventPath!"
    for %%f in ("%~dp0event\equips\*.json") do (
        set "fileName=%%~nxf"
        REM 清理旧文件
        if exist "!equipsPath!\!fileName!" (
            del /q "!equipsPath!\!fileName!"
            if errorlevel 1 (
                echo [错误] 删除旧装备文件失败: "!equipsPath!\!fileName!"
                exit /b 1
            )
        )
    )

     set "equipsPath=!eventPath!"
     for %%f in ("%~dp0event\trigger_events\*.json") do (
         set "fileName=%%~nxf"
         REM 清理旧文件
         if exist "!equipsPath!\!fileName!" (
             del /q "!equipsPath!\!fileName!"
             if errorlevel 1 (
                 echo [错误] 删除旧事件触发器文件失败: "!equipsPath!\!fileName!"
                 exit /b 1
             )
         )
     )

    set "equipsPath=!eventPath!"
     for %%f in ("%~dp0event\trigger_events_index\*.json") do (
         set "fileName=%%~nxf"
         REM 清理旧文件
         if exist "!equipsPath!\!fileName!" (
             del /q "!equipsPath!\!fileName!"
             if errorlevel 1 (
                 echo [错误] 删除旧事件触发器索引文件失败: "!equipsPath!\!fileName!"
                 exit /b 1
             )
         )
     )

    set "equipsPath=!eventPath!"
     for %%f in ("%~dp0event\chars\*.json") do (
         set "fileName=%%~nxf"
         REM 清理旧文件
         if exist "!equipsPath!\!fileName!" (
             del /q "!equipsPath!\!fileName!"
             if errorlevel 1 (
                 echo [错误] 删除旧移除角色事件失败: "!equipsPath!\!fileName!"
                 exit /b 1
             )
         )

     )

    echo 所有文件已删除，cards和upgrades请手动处理
    timeout /t 5 >nul
) else (
    echo 游戏路径不存在，请检查输入的路径是否正确："%gamePath%"
)
endlocal