@echo off
REM 设置控制台代码页为 UTF-8
chcp 65001 >nul
setlocal enabledelayedexpansion

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

    REM === 移除额外的TAG仪式（用于触发事件） ====
    for %%f in ("%~dp0rite\tags_rite\*.json") do (
        set "fileName=%%~nxf"
        REM 清理旧文件
        if exist "!ceremonyPath!\!fileName!" (
            echo 正在删除旧TAG仪式文件："!fileName!"
            del /q "!ceremonyPath!\!fileName!"
            if errorlevel 1 (
                echo [错误] 删除旧TAG特殊仪式文件失败: "!ceremonyPath!\!fileName!"
                exit /b 1
            )
        )
    )

    REM === 清理复制可触发仪式====
    for %%f in ("%~dp0rite\trigger_rites\*.json") do (
        set "fileName=%%~nxf"
        REM 清理旧文件
        if exist "!ceremonyPath!\!fileName!" (
            echo 正在删除旧可触发仪式文件："!fileName!"
            del /q "!ceremonyPath!\!fileName!"
            if errorlevel 1 (
                echo [错误] 删除可触发仪式失败: "!ceremonyPath!\!fileName!"
                exit /b 1
            )
        )
    )

    REM === 3. 移除事件、道具和装备文件 ===
    set "eventPath=%gamePath%\Sultan's Game_Data\StreamingAssets\config\event"
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
             echo 正在删除旧事件触发器文件"!fileName!"
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

     set "equipsPath=!eventPath!"
     for %%f in ("%~dp0event\tags_event\*.json") do (
         set "fileName=%%~nxf"
         REM 清理旧文件
         if exist "!equipsPath!\!fileName!" (
             del /q "!equipsPath!\!fileName!"
             echo 正在删除旧TAG事件文件"!fileName!"
             if errorlevel 1 (
                 echo [错误] 删除旧tag事件失败: "!equipsPath!\!fileName!"
                 exit /b 1
             )
         )
     )


    @REM 清理可触发rite索引
    set "equipsPath=!eventPath!"
    for %%f in ("%~dp0event\trigger_rites_index\*.json") do (
         set "fileName=%%~nxf"
         REM 清理旧文件
         if exist "!equipsPath!\!fileName!" (
             echo 正在删除旧可触发rite索引文件"!fileName!"
             del /q "!equipsPath!\!fileName!"
             if errorlevel 1 (
                 echo [错误] 删除可触发rite索引失败: "!equipsPath!\!fileName!"
                 exit /b 1
             )
         )
     )

    @REM 清理可触发rite索引
    set "equipsPath=!eventPath!"
    for %%f in ("%~dp0event\delete_rites_index\*.json") do (
         set "fileName=%%~nxf"
         REM 清理旧文件
         if exist "!equipsPath!\!fileName!" (
             echo 正在删除"!fileName!"
             del /q "!equipsPath!\!fileName!"
             if errorlevel 1 (
                 echo [错误] 删除: "!equipsPath!\!fileName!" 失败
                 exit /b 1
             )
         )
     )

    @REM 替换回upgrades和cards
    set "backupPath=%~dp0DON'T_EDIT_THIS"
    echo !backupPath!
    echo 正在修复upgrade.json
    copy /y "!backupPath!\upgrade.json" "!dataPath!\upgrade.json" >nul
    echo 正在修复cards.json
    copy /y "!backupPath!\cards.json" "!dataPath!\cards.json" >nul
    echo 正在修复俺寻思
    copy /y "!backupPath!\rite\5000002.json" "!dataPath!\rite\5000002.json" >nul
    echo 正在修复开始事件
    copy /y "!backupPath!\event\5310003.json" "!dataPath!\event\5310003.json" >nul

    echo mod已经移除
    timeout /t 2 >nul
) else (
    echo 游戏路径不存在，请检查输入的路径是否正确："%gamePath%"
)
endlocal
pause