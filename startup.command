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
    echo "游戏路径存在，开始执行文件替换操作."

    # === 1. 替换卡牌和商店配置 ===
    dataPath="${gamePath}/Sultan's Game.app/Contents/Resources/Data/StreamingAssets/config"
    echo "数据路径：\"${dataPath}\""

    if ! cp -f "$(dirname "$0")/cards.json" "${dataPath}/cards.json"; then
        echo "[错误] 复制cards.json失败"
        exit 1
    fi
    if ! cp -f "$(dirname "$0")/upgrade.json" "${dataPath}/upgrade.json"; then
        echo "[错误] 复制upgrade.json失败"
        exit 1
    fi
    echo "卡牌和商店配置已更新."

    # === 2. 添加仪式文件 ===
    ceremonyPath="${gamePath}/Sultan's Game.app/Contents/Resources/Data/StreamingAssets/config/rite"

    for file in "$(dirname "$0")/rite"/*.json; do
        fileName=$(basename "$file")

        if [ -f "${ceremonyPath}/${fileName}" ]; then
            if ! rm -f "${ceremonyPath}/${fileName}"; then
                echo "[错误] 删除旧仪式文件失败: ${ceremonyPath}/${fileName}"
                exit 1
            fi
        fi
        echo "[INFO] 正在添加仪式：${fileName}"
        if ! cp -f "${file}" "${ceremonyPath}/${fileName}"; then
            echo "[错误] 仪式文件复制失败: ${file}"
            exit 1
        fi
    done

    # === 添加额外的仪式（用于触发事件） ====
    for file in "$(dirname "$0")/rite/rites"/*.json; do
        fileName=$(basename "$file")
        # 清理旧文件
        if [ -f "$ceremonyPath/$fileName" ]; then
            if ! rm -f "$ceremonyPath/$fileName"; then
                echo "[错误] 删除旧特殊仪式文件失败: $ceremonyPath/$fileName"
                exit 1
            fi
        fi
        echo "[INFO] 正在添加仪式：$fileName"
        if ! cp -f "$file" "$ceremonyPath/$fileName"; then
            echo "[错误] 仪式文件复制失败: $file"
            exit 1
        fi
    done

    # === 添加额外的仪式（用于触发tag添加） ====
    for file in "$(dirname "$0")/rite/tags_rite"/*.json; do
        fileName=$(basename "$file")
        # 清理旧文件
        if [ -f "$ceremonyPath/$fileName" ]; then
            if ! rm -f "$ceremonyPath/$fileName"; then
                echo "[错误] 删除旧TAG仪式文件失败: $ceremonyPath/$fileName"
                exit 1
            fi
        fi
        echo "[INFO] 正在添加TAG仪式：$fileName"
        if ! cp -f "$file" "$ceremonyPath/$fileName"; then
            echo "[错误] TAG仪式文件复制失败: $file"
            exit 1
        fi
    done

    # === 复制可触发仪式（本质上是对于原本仪式的一套备份） ====
    for file in "$(dirname "$0")/rite/trigger_rites"/*.json; do
        fileName=$(basename "$file")
        # 清理旧文件
        if [ -f "$ceremonyPath/$fileName" ]; then
            if ! rm -f "$ceremonyPath/$fileName"; then
                echo "[错误] 删除可触发仪式失败: $ceremonyPath/$fileName"
                exit 1
            fi
        fi
        echo "[INFO] 正在添加可触发仪式：$fileName"
        if ! cp -f "$file" "$ceremonyPath/$fileName"; then
            echo "[错误] 可触发仪式文件复制失败: $file"
            exit 1
        fi
    done

    # === 3. 添加事件、道具和装备文件 ===
    eventPath="${gamePath}/Sultan's Game.app/Contents/Resources/Data/StreamingAssets/config/event"

    for file in "$(dirname "$0")/event"/*.json; do
        fileName=$(basename "$file")
        # 清理旧文件
        if [ -f "$eventPath/$fileName" ]; then
            if ! rm -f "$eventPath/$fileName"; then
                echo "[错误] 删除旧事件文件失败: $eventPath/$fileName"
                exit 1
            fi
        fi
        echo "[INFO] 正在添加事件：$fileName"
        if ! cp -f "$file" "$eventPath/$fileName"; then
            echo "[错误] 事件文件复制失败: $file"
            exit 1
        fi
    done

    for file in "$(dirname "$0")/event/items"/*.json; do
        fileName=$(basename "$file")
        # 清理旧文件
        if [ -f "$eventPath/$fileName" ]; then
            if ! rm -f "$eventPath/$fileName"; then
                echo "[错误] 删除旧道具文件失败: $eventPath/$fileName"
                exit 1
            fi
        fi
        echo "[INFO] 正在添加道具：$fileName"
        if ! cp -f "$file" "$eventPath/$fileName"; then
            echo "[错误] 道具文件复制失败: $file"
            exit 1
        fi
    done

    for file in "$(dirname "$0")/event/equips"/*.json; do
        fileName=$(basename "$file")
        # 清理旧文件
        if [ -f "$eventPath/$fileName" ]; then
            if ! rm -f "$eventPath/$fileName"; then
                echo "[错误] 删除旧装备文件失败: $eventPath/$fileName"
                exit 1
            fi
        fi
        echo "[INFO] 正在添加装备：$fileName"
        if ! cp -f "$file" "$eventPath/$fileName"; then
            echo "[错误] 装备文件复制失败: $file"
            exit 1
        fi
    done

    for file in "$(dirname "$0")/event/trigger_events"/*.json; do
        fileName=$(basename "$file")
        # 清理旧文件
        if [ -f "$eventPath/$fileName" ]; then
            if ! rm -f "$eventPath/$fileName"; then
                echo "[错误] 删除旧事件触发器文件失败: $eventPath/$fileName"
                exit 1
            fi
        fi
        echo "[INFO] 正在添加事件触发器：$fileName"
        if ! cp -f "$file" "$eventPath/$fileName"; then
            echo "[错误] 事件触发器复制失败: $file"
            exit 1
        fi
    done

    for file in "$(dirname "$0")/event/trigger_events_index"/*.json; do
        fileName=$(basename "$file")
        # 清理旧文件
        if [ -f "$eventPath/$fileName" ]; then
            if ! rm -f "$eventPath/$fileName"; then
                echo "[错误] 删除旧事件触发器索引文件失败: $eventPath/$fileName"
                exit 1
            fi
        fi
        echo "[INFO] 正在添加事件触发器的索引：$fileName"
        if ! cp -f "$file" "$eventPath/$fileName"; then
            echo "[错误] 事件触发器复制失败: $file"
            exit 1
        fi
    done

    for file in "$(dirname "$0")/event/chars"/*.json; do
        fileName=$(basename "$file")
        # 清理旧文件
        if [ -f "$eventPath/$fileName" ]; then
            if ! rm -f "$eventPath/$fileName"; then
                echo "[错误] 删除旧添加角色事件失败: $eventPath/$fileName"
                exit 1
            fi
        fi
        echo "[INFO] 正在添加添加角色事件的索引：$fileName"
        if ! cp -f "$file" "$eventPath/$fileName"; then
            echo "[错误] 添加角色事件复制失败: $file"
            exit 1
        fi
    done

    for file in "$(dirname "$0")/event/tags_event"/*.json; do
        fileName=$(basename "$file")
        # 清理旧文件
        if [ -f "$eventPath/$fileName" ]; then
            if ! rm -f "$eventPath/$fileName"; then
                echo "[错误] 删除旧TAG事件失败: $eventPath/$fileName"
                exit 1
            fi
        fi
        echo "[INFO] 正在添加TAG事件的索引：$fileName"
        if ! cp -f "$file" "$eventPath/$fileName"; then
            echo "[错误] 添加TAG事件索引失败: $file"
            exit 1
        fi
    done

    for file in "$(dirname "$0")/event/trigger_rites_index"/*.json; do
        fileName=$(basename "$file")
        # 清理旧文件
        if [ -f "$eventPath/$fileName" ]; then
            if ! rm -f "$eventPath/$fileName"; then
                echo "[错误] 删除可触发rite索引失败: $eventPath/$fileName"
                exit 1
            fi
        fi
        echo "[INFO] 正在添加可触发rite索引的索引：$fileName"
        if ! cp -f "$file" "$eventPath/$fileName"; then
            echo "[错误] 添加可触发rite索引失败: $file"
            exit 1
        fi
    done

    for file in "$(dirname "$0")/event/delete_rites_index"/*.json; do
        fileName=$(basename "$file")
        # 清理旧文件
        if [ -f "$eventPath/$fileName" ]; then
            if ! rm -f "$eventPath/$fileName"; then
                echo "[错误] 删除可索引失败: $eventPath/$fileName"
                exit 1
            fi
        fi
        echo "[INFO] 正在添加索引：$fileName"
        if ! cp -f "$file" "$eventPath/$fileName"; then
            echo "[错误] 添加: $file"
            exit 1
        fi
    done

    echo "所有文件已成功复制到游戏目录！"
    sleep 2
else
    echo "游戏路径不存在，请检查输入的路径是否正确：\"$gamePath\""
fi