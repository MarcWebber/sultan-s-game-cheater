@echo off
REM 设置控制台代码页为 UTF-8
chcp 65001 >nul
setlocal enabledelayedexpansion
title 简易Mod安装器
color 0A

:: ==============================
:: 设置应用ID 和 最终子文件夹名称
set "APP_ID=3117820"
set "MOD_FOLDER_NAME=sultan's_game_cheater"
:: ==============================

:: 获取当前目录
set "SOURCE_DIR=%~dp0"
set "SOURCE_DIR=%SOURCE_DIR:~0,-1%"

echo --------------------------------------------------------
echo 1.当前Mod文件夹:"%SOURCE_DIR%"
echo --------------------------------------------------------
echo 2.请输入你的Steam内容路径。目标应该是类似 ...\steamapps\workshop\content\3117820
echo --------------------------------------------------------
echo 3.[操作方法]: 直接把目标文件夹【拖拽】到本窗口中，然后回车。
echo --------------------------------------------------------


set /p "TARGET_DIR=请拖入目标文件夹: "

:: 去除引号
set "TARGET_DIR=%TARGET_DIR:"=%"

:: 简单检查
if "%TARGET_DIR%"=="" (
    echo [错误] 你没有输入任何路径！
    pause
    exit
)

:: 构建最终目标路径，在输入路径后添加子目录
set "FINAL_DESTINATION=%TARGET_DIR%\%MOD_FOLDER_NAME%"

echo.
echo [正在复制] 从 "%SOURCE_DIR%" 到 "%FINAL_DESTINATION%" ...
echo.

:: 执行复制
robocopy "%SOURCE_DIR%" "%FINAL_DESTINATION%" /E /IS /XF "%~nx0" /XD .git

echo.
echo --------------------------------------------------------
echo [完成] 文件已复制到 "%MOD_FOLDER_NAME%" 目录。
echo [提示] 窗口未关闭，请检查上方是否有Robocopy的错误或警告信息。
echo --------------------------------------------------------
echo.
pause