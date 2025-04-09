@echo off
REM 设置控制台代码页为 UTF-8
chcp 65001 >nul
REM 检查git命令是否可用
where git >nul 2>&1
if %errorlevel% equ 0 (
    echo Git 命令存在，开始执行 git pull 操作...
    cd /d "%~dp0"
    REM 拉取远程master分支
    git pull origin master
    if %errorlevel% equ 0 (
        echo 成功拉取远程 master 分支。
    ) else (
        echo 拉取远程 master 分支时出错。
    )
) else (
    echo Git 命令不存在，跳过 git pull 操作。
)