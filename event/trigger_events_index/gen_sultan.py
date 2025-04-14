import json
import os
import re

import pypinyin

import utils

# 用于记录已经被记录的卡牌
card_pool = []
item_cards = [[] for _ in range(26)]
item_cards_name_id_pairs = {}
# 根据字母表牌字典
item_cards_alphabet_start_index = {}
PAGE_SIZE = 8


def get_item_cards():
    # 生成一个长度为26的列表，每个元素是一个空列表
    pages = []
    with open(os.path.join(os.path.dirname(__file__), 'cards.json'), 'r', encoding='utf-8') as f:
        data = json.load(f)
    for card_id in data.keys():
        _card = data[card_id]
        if _card['type'] == 'item' and _card['type'] in ["item"] and _card["title"] != "情报":
            name = _card['name']
            item_cards_name_id_pairs[name] = card_id
            name_eng = re.sub(r'[\u4e00-\u9fa5]', lambda x: pypinyin.lazy_pinyin(x.group(0))[0], name)

            # 根据首字母放入对应的box
            index = ord(name_eng[0].lower()) - ord('a')
            if 0 <= index < 26:
                item_cards[index].append(name)

    event_id = 5367200
    for i in range(len(item_cards)):
        page = []
        counter = 1
        cards = item_cards[i]
        for card in cards:
            page.append({'text': card, 'tag': f"op{counter}"})
            name_eng = re.sub(r'[\u4e00-\u9fa5]', lambda x: pypinyin.lazy_pinyin(x.group(0))[0], card)
            first_name = name_eng[0].lower()
            if first_name not in item_cards_alphabet_start_index:
                item_cards_alphabet_start_index[first_name] = event_id
            counter += 1
            if counter >= PAGE_SIZE-2:
                page.append({'text': '上一页', 'tag': f"op{counter}"})
                page.append({'text': '下一页', 'tag': f"op{counter + 1}"})
                page.append({'text': '返回', 'tag': f"op{counter + 2}"})
                event_id += 1
                counter = 1
                pages.append(page)
                page = []
        if page:
            # 添加上一页
            page.append({'text': '上一页', 'tag': f"op{counter}"})
            pages.append(page)
            event_id += 1
    return pages


def get_item_card_ops():
    event_id = 5367200
    pages = []
    for i in range(len(item_cards)):
        counter = 1
        cards = item_cards[i]
        ops = {}
        for card in cards:
            op = {}
            name = card
            card_id = item_cards_name_id_pairs[card]
            resource = f"cards/{card_id}"
            prompt = {'id': f"{event_id}" + f"_prompt_{counter}", 'text': f"你選擇了{name}", 'icon': resource}
            op['g.card'] = [card_id, "已拥有+1"]
            op['prompt'] = prompt
            ops[f'case:op{counter}'] = op
            counter += 1

            if counter >= PAGE_SIZE-2:
                op = {'event_on': event_id - 1, 'event_off': event_id}
                ops[f'case:op{counter}'] = op
                op = {'event_on': event_id + 1, 'event_off': event_id}
                ops[f'case:op{counter + 1}'] = op
                op = {'event_off': event_id}
                ops[f'case:op{counter + 2}'] = op
                counter = 1
                event_id += 1
                pages.append(ops)
                ops = {}

        if ops:
            # 添加上一页
            op = {'event_on': event_id - 1}
            ops[f'case:op{counter}'] = op
            pages.append(ops)
            event_id += 1
    return pages


# 用于构建索引，构建从A-Z的索引，并创建列表
def create_index():
    pages = []
    page = []
    counter = 1
    for i in item_cards_alphabet_start_index.keys():
        index = i.upper()
        # 创建索引
        page.append({'text': index, 'tag': f"op{counter}"})
        counter += 1
        if counter >= PAGE_SIZE-2:
            page.append({'text': '上一页', 'tag': f"op{counter}"})
            page.append({'text': '下一页', 'tag': f"op{counter + 1}"})
            page.append({'text': '返回', 'tag': f"op{counter + 2}"})
            pages.append(page)
            page = []
            counter = 1
    if page:
        page.append({'text': '上一页', 'tag': f"op{len(page) + 1}"})
        pages.append(page)
    return pages


def create_index_ops():
    _event_id = 5367360
    pages = []
    page = {}
    counter = 1
    for i in item_cards_alphabet_start_index.keys():
        op = {'event_on': item_cards_alphabet_start_index[i]}
        page[f'case:op{counter}'] = op
        counter += 1
        if counter >= PAGE_SIZE-2:
            op = {'event_on': _event_id - 1, 'event_off': _event_id}
            page[f'case:op{counter}'] = op
            op = {'event_on': _event_id + 1, 'event_off': _event_id}
            page[f'case:op{counter + 1}'] = op
            op = {'event_off': _event_id}
            page[f'case:op{counter + 2}'] = op
            pages.append(page)
            page = {}
            _event_id += 1
            counter = 1

    if page:
        op = {}
        op['event_on'] = _event_id - 1
        page[f'case:op{len(item_cards_alphabet_start_index) + 1}'] = op
        pages.append(page)
        _event_id += 1

    return pages


if __name__ == '__main__':

    pages_1 = get_item_cards()
    pages_2 = get_item_card_ops()
    event_id = 5367200
    for items, options in zip(pages_1, pages_2):
        with open(os.path.join(os.path.dirname(__file__), f'items/{event_id}.json'), 'w', encoding='utf-8') as f:
            content = utils.build_item_events(event_id, "选择道具", items, options)
            f.write(json.dumps(content, ensure_ascii=False, indent=4))
        event_id += 1

    pages_1 = create_index()
    pages_2 = create_index_ops()
    event_id = 5367360
    for items, options in zip(pages_1, pages_2):
        with open(os.path.join(os.path.dirname(__file__), f'items/{event_id}.json'), 'w', encoding='utf-8') as f:
            content = utils.build_item_events(event_id, "起始字母", items, options)
            f.write(json.dumps(content, ensure_ascii=False, indent=4))
        event_id += 1
