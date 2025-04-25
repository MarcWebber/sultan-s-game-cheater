#!/bin/bash
# 提示用户输入游戏路径
currentUser=$(whoami)
defaultPath="/Users/${currentUser}/Library/Application Support/Steam/steamapps/common/Sultan's Game"
echo "请输入游戏路径（默认为${defaultPath}，如无变动回车即可）："
read -r inputPath

if [ -z "$inputPath" ]; then
    gamePath="$defaultPath"
else
    gamePath="$inputPath"
fi

if [[ $gamePath == \"*\" ]]; then
    gamePath="${gamePath:1:-1}"
fi
if [[ $gamePath == \'*\' ]]; then
    gamePath="${gamePath:1:-1}"
fi

# 检查路径是否存在
if [ -d "$gamePath" ]; then
    echo "游戏路径存在，开始执行文件移除操作."

    # === 1. 替换卡牌和商店配置 ===
    dataPath="${gamePath}/Sultan's Game.app/Contents/Resources/Data/StreamingAssets/config"
    echo "数据路径：\"${dataPath}\""

    # === 2. 移除仪式文件 ===
    ceremonyPath="${dataPath}/rite"
    for file in "$(dirname "$0")/rite"/*.json; do
        if [ -f "$file" ]; then
            fileName=$(basename "$file")
            # 清理旧文件
            if [ -f "${ceremonyPath}/${fileName}" ]; then
                echo "正在删除旧仪式文件：${fileName}"
                if ! rm -f "${ceremonyPath}/${fileName}"; then
                    echo "[错误] 删除旧仪式文件失败: ${ceremonyPath}/${fileName}"
                    exit 1
                fi
            fi
        fi
    done

    # === 移除额外的仪式（用于触发事件） ====
    for file in "$(dirname "$0")/rite/rites"/*.json; do
        if [ -f "$file" ]; then
            fileName=$(basename "$file")
            # 清理旧文件
            if [ -f "${ceremonyPath}/${fileName}" ]; then
                echo "正在删除旧仪式文件：${fileName}"
                if ! rm -f "${ceremonyPath}/${fileName}"; then
                    echo "[错误] 删除旧特殊仪式文件失败: ${ceremonyPath}/${fileName}"
                    exit 1
                fi
            fi
        fi
    done

    # === 移除额外的TAG仪式（用于触发事件） ====
    for file in "$(dirname "$0")/rite/tags_rite"/*.json; do
        if [ -f "$file" ]; then
            fileName=$(basename "$file")
            # 清理旧文件
            if [ -f "${ceremonyPath}/${fileName}" ]; then
                echo "正在删除旧TAG仪式文件：${fileName}"
                if ! rm -f "${ceremonyPath}/${fileName}"; then
                    echo "[错误] 删除旧TAG特殊仪式文件失败: ${ceremonyPath}/${fileName}"
                    exit 1
                fi
            fi
        fi
    done

    # === 清理复制可触发仪式====
    for file in "$(dirname "$0")/rite/trigger_rites"/*.json; do
        if [ -f "$file" ]; then
            fileName=$(basename "$file")
            # 清理旧文件
            if [ -f "${ceremonyPath}/${fileName}" ]; then
                echo "正在删除旧可触发仪式文件：${fileName}"
                if ! rm -f "${ceremonyPath}/${fileName}"; then
                    echo "[错误] 删除可触发仪式失败: ${ceremonyPath}/${fileName}"
                    exit 1
                fi
            fi
        fi
    done

    # === 3. 移除事件、道具和装备文件 ===
    eventPath="${dataPath}/event"

    for file in "$(dirname "$0")/event"/*.json; do
        if [ -f "$file" ]; then
            fileName=$(basename "$file")
            # 清理旧文件
            if [ -f "${eventPath}/${fileName}" ]; then
                echo "正在删除旧事件文件：${fileName}"
                if ! rm -f "${eventPath}/${fileName}"; then
                    echo "[错误] 删除旧事件文件失败: ${eventPath}/${fileName}"
                    exit 1
                fi
            fi
        fi
    done

    for file in "$(dirname "$0")/event/items"/*.json; do
        if [ -f "$file" ]; then
            fileName=$(basename "$file")
            # 清理旧文件
            if [ -f "${eventPath}/${fileName}" ]; then
                if ! rm -f "${eventPath}/${fileName}"; then
                    echo "[错误] 删除旧道具文件失败: ${eventPath}/${fileName}"
                    exit 1
                fi
            fi
        fi
    done

    for file in "$(dirname "$0")/event/equips"/*.json; do
        if [ -f "$file" ]; then
            fileName=$(basename "$file")
            # 清理旧文件
            if [ -f "${eventPath}/${fileName}" ]; then
                if ! rm -f "${eventPath}/${fileName}"; then
                    echo "[错误] 删除旧装备文件失败: ${eventPath}/${fileName}"
                    exit 1
                fi
            fi
        fi
    done

    for file in "$(dirname "$0")/event/trigger_events"/*.json; do
        if [ -f "$file" ]; then
            fileName=$(basename "$file")
            # 清理旧文件
            if [ -f "${eventPath}/${fileName}" ]; then
                echo "正在删除旧事件触发器文件 ${fileName}"
                if ! rm -f "${eventPath}/${fileName}"; then
                    echo "[错误] 删除旧事件触发器文件失败: ${eventPath}/${fileName}"
                    exit 1
                fi
            fi
        fi
    done

    for file in "$(dirname "$0")/event/trigger_events_index"/*.json; do
        if [ -f "$file" ]; then
            fileName=$(basename "$file")
            # 清理旧文件
            if [ -f "${eventPath}/${fileName}" ]; then
                if ! rm -f "${eventPath}/${fileName}"; then
                    echo "[错误] 删除旧事件触发器索引文件失败: ${eventPath}/${fileName}"
                    exit 1
                fi
            fi
        fi
    done

    for file in "$(dirname "$0")/event/chars"/*.json; do
        if [ -f "$file" ]; then
            fileName=$(basename "$file")
            # 清理旧文件
            if [ -f "${eventPath}/${fileName}" ]; then
                if ! rm -f "${eventPath}/${fileName}"; then
                    echo "[错误] 删除旧移除角色事件失败: ${eventPath}/${fileName}"
                    exit 1
                fi
            fi
        fi
    done

    for file in "$(dirname "$0")/event/tags_event"/*.json; do
        if [ -f "$file" ]; then
            fileName=$(basename "$file")
            # 清理旧文件
            if [ -f "${eventPath}/${fileName}" ]; then
                echo "正在删除旧TAG事件文件 ${fileName}"
                if ! rm -f "${eventPath}/${fileName}"; then
                    echo "[错误] 删除旧tag事件失败: ${eventPath}/${fileName}"
                    exit 1
                fi
            fi
        fi
    done

    for file in "$(dirname "$0")/event/trigger_rites_index"/*.json; do
        if [ -f "$file" ]; then
            fileName=$(basename "$file")
            # 清理旧文件
            if [ -f "${eventPath}/${fileName}" ]; then
                echo "正在删除旧可触发rite索引文件 ${fileName}"
                if ! rm -f "${eventPath}/${fileName}"; then
                    echo "[错误] 删除可触发rite索引失败: ${eventPath}/${fileName}"
                    exit 1
                fi
            fi
        fi
    done

    for file in "$(dirname "$0")/event/delete_rites_index"/*.json; do
        if [ -f "$file" ]; then
            fileName=$(basename "$file")
            # 清理旧文件
            if [ -f "${eventPath}/${fileName}" ]; then
                echo "正在删除索引文件 ${fileName}"
                if ! rm -f "${eventPath}/${fileName}"; then
                    echo "[错误] 删除索引失败: ${eventPath}/${fileName}"
                    exit 1
                fi
            fi
        fi
    done

    # 替换回upgrades和cards
    backupPath="$(dirname "$0")/DON'T_EDIT_THIS"
    echo "正在修复upgrade.json"
    if ! cp -f "${backupPath}/upgrade.json" "${dataPath}/upgrade.json"; then
        echo "[错误] 修复upgrade.json失败"
        exit 1
    fi
    echo "正在修复cards.json"
    if ! cp -f "${backupPath}/cards.json" "${dataPath}/cards.json"; then
        echo "[错误] 修复cards.json失败"
        exit 1
    fi
    echo "正在修复俺寻思"
    if ! cp -f "${backupPath}/rite/5000002.json" "${dataPath}/rite/5000002.json"; then
        echo "[错误] 修复俺寻思失败"
        exit 1
    fi
    echo "正在修复开始事件"
    if ! cp -f "${backupPath}/event/5310003.json" "${dataPath}/event/5310003.json"; then
        echo "[错误] 修复开始事件失败"
        exit 1
    fi

    echo "mod已经移除"
    sleep 2
else
    echo "游戏路径不存在，请检查输入的路径是否正确：\"$gamePath\""
fi