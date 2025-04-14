# 神灯作弊器V0.4

```
首先説明：使用需谨慎，本修改器未经过完善测试，可能带来BUG
这是预期将是一个通用修改器
```

## 更新说明

### 4.8更新

- [x] 添加任意情报
- [x] 可以添加指定裝備
- [x] 添加任意道具
- [x] 提升能力
- [x] 添加金钱
- [x] 添加金骰子、善名等

### 4.9更新

- [x] 强制触发事件（events，不一定都能生效，未测试完全）
- [x] 添加自动化安装脚本
- [x] 修复频繁弹出的bug
- [x] 修改道具的分页数目
- [x] 在选择过程中，添加返回

### 4.10更新

- [x] 邀请任意角色
- [x] 提升任意卡的品质
- [x] 烧毁任意卡
- [x] 更精确的控制金币，善名等的点数

### 4.12更新

#### 更新

- [x] 给角色添加任意TAG
- [x] 选择苏丹卡
- [x] 降低任意卡的品质
- [x] 重置了属性提升
- [x] 复制卡
- [x] 延长卡的时限
- [ ] 存档
- [ ] 游戏内修改速度

#### 修复

- [x] 修复选择道具上下页颠倒的bug
- [x] 修复法拉杰和铁头等人添加后不能正确使用的bug



### 4.13更新

#### 更新

- [x] 延长卡的时限：可以通过给卡添加“冻结”这个TAG实现
- [x] 添加一键删除mod的脚本
- [x] 优化：将神灯等道具全部放入了命运商店。游戏中获取可以通过寻思主角实现
- [ ] 优化：脚本优化

#### 修复

- [x] 修复神灯金钱和属性提升不可用的bug
- [x] 修复征服给杀戮的bug



## 使用説明

### 准备

双击startup.bat，输入游戏路径，一键使用

> 脚本没法运行大概率是编码的问题，解决方式如下
>
> 1. 在mod位置新建一个a.txt文件
> 2. 把startup.bat的内容复制到这个txt中
> 3. 把a.txt改名为 a.bat
> 4. 双击运行
>
> 然后，如果你手动复制文件，一定要关注rite和event中的子文件夹，正确的做法是先把rite,event中子文件夹下所有的json文件放到rite或者event中，然后再整个拖到游戏文件下。
>

### 开始使用

游戏开始，会问你是否需要神的援助，接受则获得一个神灯。

你的命运商店里会多出六个道具：

1. 神灯（万能添加）
2. 撒旦的种子（烧卡）
3. 事件召唤卡（用于强制触发事件）
4. 大苏丹的戒指（属性提升，开启额外装备槽）
5. 存档酒（暂时无效）
6. 仪式召唤卡（用于强制触发仪式）



将神灯拖入俺寻思，在家宅触发仪式，拖入对应的位置即可实现道具，角色或者金钱以及其他内容的获取。每回合可以无限使用

将事件召唤卡拖入俺寻思，在神殿触发仪式，随便放入什么，根据首字母选择仪式，然后等待一回合即可触发部分仪式

将仪式召唤卡拖入俺寻思，根据首字母选择仪式，然后等待一回合即可触发部分仪式

将神撒旦种子拖入俺寻思，在神殿触发仪式，烧卡

如果需要在游戏中加入该mod，把主角拖入寻思即可。
