@echo off
REM 设置控制台代码页为 UTF-8
chcp 65001 >nul
setlocal enabledelayedexpansion
set /p "gamePath=请输入游戏路径（eg：E:\Games\Steam\steamapps\common\Sultan's Game，注意不要带双引号）："
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
        REM 清理旧文件
        if exist "!ceremonyPath!\!fileName!" (
            del /q "!ceremonyPath!\!fileName!"
            if errorlevel 1 (
                timeout /t 10 >nul
                exit /b 1
            )
        )
        echo [INFO] 正在添加仪式："!fileName!"
        copy /y "%%f" "!ceremonyPath!\!fileName!" >nul
        if errorlevel 1 (
            echo [错误] 仪式文件复制失败: "%%f"
            exit /b 1
        )
    )

    REM === 添加额外的仪式（用于触发事件） ====
    for %%f in ("%~dp0rite\rites\*.json") do (
        set "fileName=%%~nxf"
        REM 清理旧文件
        if exist "!ceremonyPath!\!fileName!" (
            del /q "!ceremonyPath!\!fileName!"
            if errorlevel 1 (
                echo [错误] 删除旧特殊仪式文件失败: "!ceremonyPath!\!fileName!"
                exit /b 1
            )
        )
        echo [INFO] 正在添加仪式："!fileName!"
        copy /y "%%f" "!ceremonyPath!\!fileName!" >nul
        if errorlevel 1 (
            echo [错误] 仪式文件复制失败: "%%f"
            exit /b 1
        )
    )

    REM === 添加额外的仪式（用于触发tag添加） ====
    for %%f in ("%~dp0rite\tags_rite\*.json") do (
        set "fileName=%%~nxf"
        REM 清理旧文件
        if exist "!ceremonyPath!\!fileName!" (
            del /q "!ceremonyPath!\!fileName!"
            if errorlevel 1 (
                echo [错误] 删除旧TAG仪式文件失败: "!ceremonyPath!\!fileName!"
                exit /b 1
            )
        )
        echo [INFO] 正在添加TAG仪式："!fileName!"
        copy /y "%%f" "!ceremonyPath!\!fileName!" >nul
        if errorlevel 1 (
            echo [错误] TAG仪式文件复制失败: "%%f"
            exit /b 1
        )
    )

    REM === 复制可触发仪式（本质上是对于原本仪式的一套备份） ====
    for %%f in ("%~dp0rite\trigger_rites\*.json") do (
        set "fileName=%%~nxf"
        REM 清理旧文件
        if exist "!ceremonyPath!\!fileName!" (
            del /q "!ceremonyPath!\!fileName!"
            if errorlevel 1 (
                echo [错误] 删除可触发仪式失败: "!ceremonyPath!\!fileName!"
                exit /b 1
            )
        )
        echo [INFO] 正在添加可触发仪式："!fileName!"
        copy /y "%%f" "!ceremonyPath!\!fileName!" >nul
        if errorlevel 1 (
            echo [错误] 可触发仪式文件复制失败: "%%f"
            exit /b 1
        )
    )

    REM === 3. 添加事件、道具和装备文件 ===
    set "eventPath=%gamePath%\Sultan's Game_Data\StreamingAssets\config\event"
    REM 复制事件文件
    for %%f in ("%~dp0event\*.json") do (
        set "fileName=%%~nxf"
        REM 清理旧文件
        if exist "!eventPath!\!fileName!" (
            del /q "!eventPath!\!fileName!"
            if errorlevel 1 (
                echo [错误] 删除旧事件文件失败: "!eventPath!\!fileName!"
                exit /b 1
            )
        )
        echo [INFO] 正在添加事件："!fileName!"
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
        REM 清理旧文件
        if exist "!itemsPath!\!fileName!" (
            del /q "!itemsPath!\!fileName!"
            if errorlevel 1 (
                echo [错误] 删除旧道具文件失败: "!itemsPath!\!fileName!"
                exit /b 1
            )
        )
        echo [INFO] 正在添加道具："!fileName!"
        copy /y "%%f" "!itemsPath!\!fileName!" >nul
        if errorlevel 1 (
            echo [错误] 道具文件复制失败: "%%f"
            exit /b 1
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
        echo [INFO] 正在添加装备："!fileName!"
        copy /y "%%f" "!equipsPath!\!fileName!" >nul
        if errorlevel 1 (
            echo [错误] 装备文件复制失败: "%%f"
            exit /b 1
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
          echo [INFO] 正在添加事件触发器："!fileName!"
          copy /y "%%f" "!equipsPath!\!fileName!" >nul
          if errorlevel 1 (
              echo [错误] 事件触发器复制失败: "%%f"
              exit /b 1
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
         echo [INFO] 正在添加事件触发器的索引："!fileName!"
         copy /y "%%f" "!equipsPath!\!fileName!" >nul
         if errorlevel 1 (
             echo [错误] 事件触发器复制失败: "%%f"
             exit /b 1
         )
     )

    set "equipsPath=!eventPath!"
     for %%f in ("%~dp0event\chars\*.json") do (
         set "fileName=%%~nxf"
         REM 清理旧文件
         if exist "!equipsPath!\!fileName!" (
             del /q "!equipsPath!\!fileName!"
             if errorlevel 1 (
                 echo [错误] 删除旧添加角色事件失败: "!equipsPath!\!fileName!"
                 exit /b 1
             )
         )
         echo [INFO] 正在添加添加角色事件的索引："!fileName!"
         copy /y "%%f" "!equipsPath!\!fileName!" >nul
         if errorlevel 1 (
             echo [错误] 添加角色事件复制失败: "%%f"
             exit /b 1
         )
     )

    @REM 复制TAG文件（确保目标子目录存在）
    set "equipsPath=!eventPath!"
    for %%f in ("%~dp0event\tags_event\*.json") do (
         set "fileName=%%~nxf"
         REM 清理旧文件
         if exist "!equipsPath!\!fileName!" (
             del /q "!equipsPath!\!fileName!"
             if errorlevel 1 (
                 echo [错误] 删除旧TAG事件失败: "!equipsPath!\!fileName!"
                 exit /b 1
             )
         )
         echo [INFO] 正在添加TAG事件的索引："!fileName!"
         copy /y "%%f" "!equipsPath!\!fileName!" >nul
         if errorlevel 1 (
             echo [错误] 添加TAG事件索引失败: "%%f"
             exit /b 1
         )
     )

     
    @REM 复制可触发rite索引
    set "equipsPath=!eventPath!"
    for %%f in ("%~dp0event\trigger_rites_index\*.json") do (
         set "fileName=%%~nxf"
         REM 清理旧文件
         if exist "!equipsPath!\!fileName!" (
             del /q "!equipsPath!\!fileName!"
             if errorlevel 1 (
                 echo [错误] 删除可触发rite索引失败: "!equipsPath!\!fileName!"
                 exit /b 1
             )
         )
         echo [INFO] 正在添加可触发rite索引的索引："!fileName!"
         copy /y "%%f" "!equipsPath!\!fileName!" >nul
         if errorlevel 1 (
             echo [错误] 添加可触发rite索引失败: "%%f"
             exit /b 1
         )
     )
    echo 所有文件已成功复制到游戏目录！
    timeout /t 2 >nul
) else (
    echo 游戏路径不存在，请检查输入的路径是否正确："%gamePath%"
)
endlocal