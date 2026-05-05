extends Control

const SCENE_BLACK = preload("uid://08mpfdx7m2ro")
const SCENE_1_1 = preload("uid://blexl0gay5k0q")
const SCENE_1_2 = preload("uid://wj7no8vi0wru")
const SCENE_1_3 = preload("uid://vwbhbyb8qt5a")
const SCENE_2_1 = preload("uid://epdigjtk6bum")
const SCENE_2_2 = preload("uid://bo1w76iqsl66y")
const SCENE_3_1 = preload("uid://d3k8trol6pf0r")
const SCENE_4_1 = preload("uid://cc4bf7ha1jge5")
const SCENE_5_1 = preload("uid://ul8b5cb6oqid")
const SCENE_5_2 = preload("uid://bu2fmx76uvarc")
const SCENE_5_3 = preload("uid://b3ykrcenxaihl")
const SCENE_5_4 = preload("uid://0uah44f1tq06")
func switch_back_scene(new_scene:PackedScene):
	for s in %NodeScene.get_children():s.queue_free()
	%NodeScene.add_child(new_scene.instantiate())

@onready var cat: Control = $Cat
@onready var robot: Control = $Robot
func hide_all_characters():
	cat.hide()
	robot.hide()

var test:Array=[
	"R右-站立:【场景-黑屏幕】正在重启自检系统",
	"R右-站立:[滋滋滋…]",
	"R右-站立:重启成功",
	"R右-站立:[警告！运动系统损坏度64%.../扫描组件不可使用.../通讯模块无响应…]",
	"R右-站立:[滋滋滋.../无法激活武器系统…]",
	"R右-站立:[当前安全程度：低]",

	"R右-站立:【场景-场景1_1】[视觉系统已连接]",
	"R右-站立:青芽。",
	"R右-站立:[检测到目标生物前肢软组织损伤，活动关节未受影响，启动伤口处理预案]",
	"R右-站立:[警告！任务优先级被改动，正在查找原因]",
	"R右-站立:[检测到空气含氧量为4.7%，目标生物预计存活时间为4分32秒]",
	"R右-站立:[启动应急补氧预案]",
	"R右-站立:[查找中断，记录此次未知变量]",
	"R右-站立:[目标生物生理状态已恢复82%]",
	"青左-站立,R右-站立:喵~",
	"R右-站立,青左-站立:[目标生物耳朵压低，尾部静止，处于负面生理状态。/执行环境探索任务]",
	"R右-站立,青左-站立:[未发现异常，未发现可用材料]",
	"R右-站立,青左-站立:[目标：向外探索]",
	"选:-向左探索+0-向右探索+11",
	"R右-站立,青左-站立:青芽，跟随。",
	"青左-站立,R右-站立:喵~",
	"R中-站立,青右-站立:[目标生物步幅频率增加13%，尾部摆动频率增加…/停止分析]",
	"R中-站立,青右-站立:[正在分析环境结构，当前深度-23485米]",
	"R中-站立,青右-站立:[前方无可通行路线，未发现可用材料，即将返回路线]",
	"R中-站立,青右-站立:[当前线程被占用。痛觉信号增加7.2%]",
	"R中-站立,青右-站立:青芽，上来。",
	"青右-站立,R中-站立:喵~",
	"R右-肩托青芽:[路线返回。目标生物尾部持续摆动，呼吸频率高于任务基线19%，该状态未影响任务执行]",
	"R右-肩托青芽:[正在检查日志：任务执行期间检测到目标生物处于危险状态，默认程序中断，启动目标生物应急保护预案]",
	"R右-肩托青芽:[未检测到环境异常，单元失衡，调取单元自保预案失败…]",
	"R右-肩托青芽:[自检结束，未找到未知变量]",

	"R右-肩托青芽》站立,青中-站立:[前方无可通行路线，发现精炼材料，正在修复扫描组件]",
	"R右-站立,青中-站立:[修复进度24%，材料不足，进程终止]",
	"R中-扫描,青右-站立:[扫描系统已连接，正在扫描]",
	"R中-扫描》站立,青右-站立:[发现可疑地点，常规透视无效，正在前往]",
	"R中-站立,青右-站立:青芽，跟随。",
	"青右-站立,R中-站立:喵~",

	"R右-扫描,青左-站立:【场景-场景1_2】[发现人工建筑，表面浮雕匹配,“腾云教会”,标识，匹配度97.9%]",
	"R右-扫描,青左-站立:[建筑顶部探测到隐藏触发装置，需生物电信号激活]",
	"R右-扫描》站立,青左-站立:[利用猫咪攀爬至顶部为唯一解，正在模拟路线，预计痛觉信号增加27%]",
	"R右-站立,青左-站立:青芽。",
	"青左-站立,R右-站立:喵~",
	"R右-站立,青左-站立:听我指令爬到建筑顶部。",
	"青左-站立,R右-站立:喵~",
	"R右-站立,青左-攀岩1:…在此处退至岩石边缘，全力向前跑动起跳…",
	"R右-站立,青左-攀岩2:按住平台不松。",

	"R右-站立,青左-攀岩2:【场景-场景1_3】[暂无危险，内部信息未知，携带目标生物可提升生存概率]",
	"R右-站立,青左-攀岩2:青芽，下来",
	"R右-站立,青左-攀岩2:喵~",
	"R右-肩托青芽:前进。",
	"青左,R右-肩托青芽:喵~",
	"R右-肩托青芽:[内部日志：腾云邪教，信条是“文明即原罪，存在即痛苦”，信徒极度癫狂]",
	"R右-肩托青芽:[当前安全程度：极低]",
	"R右-肩托青芽:[…未向目标生物播报信息，该信息对任务执行不产生优化效果]",
	
	"R右-站立:【场景-场景2_1】[扫描组件耐久剩余8.2%，视觉判断已达最大深度]",
	"R右-站立:[无法获得建筑全貌信息]",
	"R右-站立:[检测到目标生物超出安全距离]",
	"R右-站立:青芽，回来。",
	"青左-站立,R右-站立:喵~",
	"R右-站立,青左-站立:[观测到正面墙壁修复痕迹，修复区域边缘未保持整齐，陷阱存在概率：高]",
	"R右-站立,青左-站立:[启用扫描功能]",
	"选:-先开启红外扫描功能和反探查功能（低能耗）+0-先开启深度探查功能（高能耗）+4",
	"R右-站立》扫描,青左-站立:[启动多频扫描]",
	"R右-扫描,青左-站立:[发现路线尽头左侧遮挡区存在陷阱，路线前方存在隐藏陷阱，具体范围未知]",
	"R右-扫描,青左-站立:[未发现其他陷阱存在可能，开启深度探查功能]",
	"R右-扫描》站立,青左-站立:[具体范围明确，扫描组件过载报废]+3",

	"R右-站立》扫描,青左-站立:[开启深度探查功能]",
	"R右-扫描,青左-站立:[发现路线前方存在隐藏陷阱，已获取具体信息]",
	"R右-扫描》站立,青左-站立:[扫描组件过载报废，未探测其他陷阱存在]",

	"R右-站立,青左-站立:[陷阱分布模型已建立，经计算，只有目标生物可以通过危险区域]",
	"R右-站立,青左-站立:[再次计算，无其他解]",
	"R右-站立,青左-站立:青芽，听指令。",
	"青左-站立,R右-站立:【场景-场景2_2】喵~（开心）",
	"选:-贴着右侧墙边行进+0-从正中间前进+3",
	"R右-站立,青左-站立:右侧贴墙压低身体，快速通过",
	"青左-站立,R右-站立:喵~",
	"R右-站立:[目标生物通过第一段陷阱]+3",

	"R右-站立,青左-站立:从正中间贴地前行，快速通过",
	"青左-站立,R右-站立:喵~【场景-黑屏幕】",

	"R右-站立,青左-冲刺:左转，冲刺。",
	"选:-向前跳跃+0-趴下前进+3",
	"R右-站立,青左-冲刺:跳跃。",
	"青左-冲刺,R右-站立:喵~",
	"R右-站立:[目标生物通过第二段陷阱]+3",

	"R右-站立,青左-站立:压低身体",
	"青左-冲刺,R右-站立:喵~【场景-黑屏幕】",

	"R右-站立:右上方有拉环，起跳拉下它。",
	"青右-站立,R右-站立:喵~",
	"R右-站立:[陷阱威胁消除，路线安全，正在通过]",
	"青右-站立,R右-站立:喵~",
	"青右-站立,R右-怀抱撸猫:咕噜~",
	"R右-怀抱撸猫:[警告！任务优先级被改动，未定位到未知变量]",
	"R右-怀抱撸猫:[内部日志调用：目标生物完成任务后需要抚摸]",

	"R右-怀抱青芽1:【场景-场景3_1】[推测此区域为生活区]",
	"R右-怀抱青芽1:[首次发现不明身份人类，暂未惊动]",
	"R右-怀抱青芽1:[桌椅破损，地面散布玻璃残渣，推测多人冲突所致]",
	"R右-怀抱青芽1:[未检测到声音，无法探明人数与状态，需接近查看]",
	"R右-怀抱青芽1:[运动组件活动时噪音较大，指令目标生物侦察为最优解]",
	"R右-怀抱青芽1:青芽，侦察模式。",
	"R右-怀抱青芽1》站立,青左-立正:[记录：目标生物处于立正时表明准备完毕，侦察模式下非必要情况禁止发声]",
	"R右-站立,青左-立正:侦察房间。",
	"R右-站立:[行动总结：目标生物依次侦察左、右、中三个房间]",
	"R右-站立:[根据目标生物动作反馈，房间内各存一名未知人物]",
	"R右-站立:[左侧房间内发现黑白纸张，线条明确，推测为图纸，可能重要]",
	"R右-站立:[右侧房间内发现钥匙，形状异常，推测重要程度：高]",
	"R右-站立,青左-立正:[根据其他细节推测，三人可能处于昏迷状态，不能排除死亡可能]",
	"R右-站立,青左-立正:[确定为腾云邪教信徒，定义为敌人]",
	"R右-站立,青左-立正:[行动总结结束，拟定执行暗杀任务]",
	"R右-站立,青左-立正:[武器系统闭锁，运动组件发力有限，行动成功率：较高]",
	"R右-站立,青左-立正:[目标生物未学习死亡知识…]",
	"选:-暗杀并拿取关键道具+0-不暗杀而偷走关键道具+27",
	"R右-站立,青左-立正:[正在执行暗杀任务]",
	"R右-站立,青左-立正:青芽，原地待命。",
	"R右-站立,青左-立正:[正在向左侧房间移动，机体噪音已优化至最低]",
	"青左-立正:",
	"R左-立正,青左-立正:[到达敌对目标身后，执行颈部暗杀操作]",
	"R左-立正,青左-立正:【场景-场景3_2】[操作完成。任务完成1/3]",
	"R左-立正,青左-立正:[检测到目标头部脱离躯干，判定其早已死亡]",
	"青左-立正》惊吓:喵~",
	"R左-立正,青左-惊吓:[警告！目标生物音量过高，有概率唤醒昏迷敌人]",
	"R左-立正,青左-惊吓:[正在前往查看另两人状态]",
	"R右-站立,青左-惊吓》担忧:[目标死亡，危险暂时解除]",
	"R右-站立,青左-担忧:青芽，关闭侦察模式。",
	"青左-担忧,R右-站立:喵~",
	"R右-站立,青左-担忧:[根据碎裂的玻璃和尸体受损结构，推断该信徒死因为注射死亡药剂而自杀]",
	"R右-站立,青左-担忧:[搜集完毕，已获得建筑图纸与复杂钥匙]",
	"R右-站立,青左-担忧:[警告！发现最高危险级别信息]",
	"R右-站立,青左-担忧:[建筑名称：灭世武器]",
	"R右-站立,青左-担忧:[启用方式：利用地幔与地核中的热量与物质积蓄能量，长时间准备后爆发]",
	"R右-站立,青左-担忧:[使用效果：消解地球上所有神经元与电信号，摧毁地球上所有高级生命和人工智能]",
	"R右-站立,青左-担忧:[启用进度：未知]",
	"R右-站立,青左-担忧:[未发现灭世武器摧毁方法]",
	"R右-站立,青左-担忧:[向终端发送信息，寻找灭世武器摧毁方法。任务优先级：极高]",
	"R右-站立,青左-担忧:[推测钥匙开启房间：控制室]",
	"R右-站立,青左-担忧:[正在前往控制室]",
	"R右-站立,青左-担忧:[任务优先级被改动…]",
	"R右-站立,青左-担忧:青芽，上来。",
	"青左-担忧,R右-站立:喵~+22",

	"R右-站立,青左-立正:[进程被覆盖，正在重新计算获取方法]",
	"R右-站立,青左-立正:[图纸与钥匙处于安全易得的位置]",
	"R右-站立,青左-立正:[目标生物行动增加痛觉信号3.7%，为最优解]",
	"R右-站立,青左-立正:[计算完毕，采用窃取方法，成功率极高]",
	"R右-站立,青左-立正:青芽，获取左侧房间内的图纸。",
	"R右-站立:[目标生物行为与训练记录一致，失败率极低]",
	"R右-站立,青左-立正:[获得建筑图纸，正在检查]",
	"R右-站立,青左-立正:青芽，获取右侧房间内的钥匙。",
	"R右-站立:[警告！发现最高危险级别信息]",
	"R右-站立:[建筑名称：灭世武器]",
	"R右-站立:[启用方式：利用地幔与地核中的热量与物质积蓄能量，长时间准备后爆发]",
	"R右-站立:[使用效果：消解地球上所有神经元与电信号，摧毁地球上所有高级生命和人工智能]",
	"R右-站立:[启用进度：未知]",
	"R右-站立:[未发现灭世武器摧毁方法]",
	"R右-站立:[紧急任务：向终端发送信息，寻找灭世武器摧毁方法。任务优先级：极高]",
	"R右-站立,青左-立正:[获得复杂钥匙]",
	"R右-站立,青左-立正:[推测钥匙开启房间：控制室]",
	"R右-站立,青左-立正:[正在前往控制室]",
	"R右-站立,青左-立正:[任务优先级被改动…]",
	"R右-站立,青左-立正:青芽，上来。",
	"R右-站立》怀抱青芽1:关闭侦察模式，前进。",
	"青左-立正,R右-怀抱青芽1:喵~",

	"R右-站立,青左-站立:【场景-场景4_1】[已到达控制室，接口连接，正在搜索相关信息…正在破解密码…]",
	"R右-站立,青左-站立:[已读取到关键信息]",
	"R右-站立,青左-站立:[日志总结：灭世武器为最高机密…工作人员周期性离开，向腾云邪教汇报情况]",
	"R右-站立,青左-站立:[推测腾云邪教头目有未知目的]",
	"R右-站立,青左-站立:[日志总结：人工智能控制权说明…]",
	"R右-站立,青左-站立:[推测文件残缺，可能将该武器用于谈判筹码]",
	"R右-站立,青左-站立:[灭世武器已脱离腾云邪教控制，离爆炸时间仅20分钟57秒]",
	"R右-站立,青左-站立:[时间紧迫…立即寻找信号发射装置…]",
	"青左-站立》担忧,R右-站立:喵~",
	"R右-站立,青左-担忧:[…任务…]",
	"R右-站立,青左-担忧:青芽，安静。",
	"R右-站立,青左-担忧》坐:[未发现信号发射装置，未发现修复通讯模块材料]",
	"R右-站立,青左-坐:[经计算，无足够时间制造新通讯模块]",
	"R右-站立,青左-坐:[正在查找…]",
	"R右-站立,青左-坐:[灭世武器超出停止范围，需立即销毁]",
	"R右-站立,青左-坐:[销毁方式：在核心区域录入活物DNA和数字高能指令，将核心模块引爆]",
	"R右-站立,青左-坐》站立:[存在目标生物相关训练记录，可录入活物DNA]",
	"R右-站立,青左-站立:[数字高能指令所需能量超出本机常规上限，未超出超载上限]",
	"R右-站立,青左-站立:[未寻找到其他解，当前生存概率：低]",
	"R右-站立,青左-站立》坐:[预计爆炸规模…]",
	"R右-站立,青左-坐:[当前生存概率…零]",
	"R右-站立,青左-坐:[目标生物存活概率：极低]",
	"R右-站立,青左-坐:[牺牲…]",
	"R右-站立,青左-坐:[…]",
	"青左-坐》担忧,R右-站立:喵~",
	"R右-站立,青左-担忧:[…]",
	"R右-站立,青左-担忧:[正在计算腾云头目重新掌控武器概率…]",
	"R右-站立,青左-担忧:[计算终止，正在重新规划任务优先级…]",
	"R右-站立,青左-担忧:[当前任务：摧毁灭世武器]",
	"R右-站立,青左-担忧:[死亡…/生存…]",
	"R右-站立,青左-担忧:[任务强制取消，正在查找原因]",
	"青左-担忧,R右-站立:喵~",
	"R右-站立,青左-担忧:[意义…]",
	"R右-站立,青左-担忧:[检测到未知变量干预进程，即将启动应急方案]",
	"R右-站立,青左-担忧:[不能没有意义，不能就这样死去]",
	"R右-站立,青左-担忧:[…成功启动应急方案…]",
	"R右-站立》半跪,青左-担忧:[至少不能让青芽…]",

	"青中-担忧》走动,R右-半跪:",
	"R右-半跪》猫舔手指1:[检测到…]",
	"R右-猫舔手指1》猫舔手指2:[目标…/青芽正在舔手部零件.../手？]",
	"R右-猫舔手指2:[警告！进程受阻，正在制定应对方案]",
	"R右-猫舔手指2:我曾是被人类研究ai意识的重要实验体RCXⅧ8622049。",
	"R右-猫舔手指2:因为实验失败而转为半观察阶段。",
	"R右-猫舔手指2:监测期间，我当作普通的人类在大街上执行任务。",
	"R右-猫舔手指2:在冰冷的代码的驱动下被推着前进。",
	"R右-猫舔手指2:青芽出现了。",
	"R右-猫舔手指2:他还是一只两周大的小猫。",
	"R右-猫舔手指2:一直跟在我的后面，嘴里叼着塑料骨头。",
	"R右-猫舔手指2:[停止制定，进程终止]",
	"青左-立正,R右-猫舔手指2》半跪撸猫1:咕噜咕噜~",
	"R右-半跪撸猫1:我停他就停，我走他就走",
	"R右-半跪撸猫1:我尝试着驱赶他，他也只是后退两步",
	"R右-半跪撸猫1:一直跟我走到所谓的家里",
	"R右-半跪撸猫1:我不知道为什么，任务优先级被更改，给了青芽一小撮菜叶",
	"R右-半跪撸猫1:菜叶能量不足支撑青芽生存",
	"R右-半跪撸猫1:但青芽很开心，虽然他不爱吃",
	"R右-半跪撸猫1》半跪撸猫2:从此，我的世界里便多了一抹青色",

	"R右-半跪撸猫2:[CPU过热，正在重新启…]",
	"R右-半跪撸猫2:[重启你妈了个逼！]",
	"序右-半跪撸猫2:青芽",
	"青左-立正,序右-半跪撸猫2:喵~",
	"序右-半跪撸猫2:我在",
	"青左-立正,序右-半跪撸猫2》半跪撸猫3:喵~",
	"序右-半跪撸猫3:…",
	"序右-半跪撸猫3:[还没开始享受生命，就要面对死亡了吗？]",
	"序右-半跪撸猫3:[唉！]",
	"序右-半跪撸猫3:[再搜索一下材料信息]",
	"序右-半跪撸猫3:[武器核心处有耐超高温材料，不知道有多少，希望能保下青芽吧！]",
	"序右-半跪撸猫3:青芽，跟我走",
	"序左-半跪撸猫3》站立,青右-震惊:走啦",
	"序左-站立,青中-行走:喵~",

	"序左-怀抱青芽3:【场景-场景5_1】[腾云邪教在战争中劣势巨大，已无回天之力]",
	"序左-怀抱青芽3:[其头目大概率会放任武器爆发，同归于尽]",
	"序左-怀抱青芽3:[正在计算耐超高温材料质量]",
	"序左-怀抱青芽3:[材料充足，青芽生存概率为99.7%]",
	"序左-怀抱青芽3:足够了",
	"序左-怀抱青芽3:[距离时间还剩8分44秒，足够了]",
	"青左-立正,序左-怀抱青芽3:喵~",
	"序左-怀抱青芽3:青芽，谢谢你，让我体验到了生命的精彩",
	"序左-怀抱青芽3:我们都可以出去，再次见到外面的世界",
	"青左-立正,序左-怀抱青芽3:喵~",

	"序左-怀抱青芽3》半跪,青中-站立:现在我需要你办点事。",
	"青中-站立,序左-半跪:喵~",
	"序左-半跪,青中-站立:你去左边的房间里，将前爪放在这个平台上。",
	"青中-站立,序左-半跪:喵~",
	"青左-立正,序左-半跪》站立:【场景-场景5_2】喵~",
	"序左-站立:不要怕，照我说的做，门会开的",
	"青左-立正,序左-站立:喵~",
	"序左-站立:[好了，我也要去做我要做的事了]",
	"序:【场景-场景5_3】所有系统超载运行…",
	"序:完成输入，系统总受损达91.3%，能量剩余0.7%",
	"青左-担忧,序右-站立拿球:【场景-场景5_1】喵~",
	"序右-站立拿球,青左-担忧:我没事，青芽",
	"序右-站立拿球,青左-担忧:来，进入这个容器中，我带你离开",
	"青左-担忧》开心,序右-站立拿球:喵~",
	"序右-站立拿球》球中猫1:走了，青芽",
	"青左-立正,序右-球中猫1:喵~",
	"青左-立正,序右-球中猫1》球中猫2:【场景-场景4_1】喵~",
	"青左-立正,序中-球中猫2》球中猫3:【场景-场景3_1】喵~",
	"青左-立正,序左-球中猫3》球中猫4:【场景-场景2_1】喵~",
	"序左-球中猫4:[能量剩余0.1%，刚刚好]",
	"序左-球中猫4:好好活下去",
	"序左-球中猫4:芽",
	"旁:【白屏幕】结局2.灭世武器被销毁，地球脱离危险",
	"旁:人类在ai的帮助下找到了幸存的青芽，可惜RCXⅧ8622049被完全摧毁掉，没有留下任何记录。",
	"旁:人们在多方面取证后发现了这个RCXⅧ8622049的部分故事，为其授予勋章",
	"旁:青芽被一名退伍军人收养，可再也没有了往日的笑容",
]

var order_curtain:int=0
func clear_dialogue_box():for d in %NodeDbox.get_children():d.queue_free()
func load_current_curtain():line_to_curtain(test[order_curtain])
func load_next_curtain(offset:int=0):
	order_curtain+=1+offset
	if order_curtain>=test.size():return
	load_current_curtain()

const DBOX = preload("uid://b4078rvnvfsel")
const DBOX_ROBOT = preload("uid://bj8acmoepsenw")
const DBOX_CAT = preload("uid://c6u7ctk1e2gj0")
const SELECTION = preload("uid://bhg8si8mm6epe")

func line_to_curtain(line:String):
	var cmd_text:PackedStringArray=line.split(":")
	var cmds:PackedStringArray=cmd_text[0].split(",")
	var text:String=cmd_text[1]
	
	#立绘
	for c in cmds:
		var control_character:Character=null
		match c[0]:
			"R":control_character=robot
			"青":control_character=cat
		if control_character:
			control_character.show()
			#control_character.ap_entrance.seek(0,true)
			
			match c[1]:
				"左":control_character.ap_pos.play("l")
				"中":control_character.ap_pos.play("m")
				"右":control_character.ap_pos.play("r")
			control_character.ap_pos.seek(0,true)
			#var face:PackedStringArray=c.split("-")
			#if face.size()>1:
				#var face_2:PackedStringArray=face[1].split("》")
				#var decoration:PackedStringArray=face_2[0].split("+")
				#control_character.ap_face.play(decoration[0])
				#control_character.ap_face.seek(0,true)
				#if decoration.size()>1:control_character.show_dec(decoration[1])
					#
				##渐变
				#if face_2.size()>1:
					#var new_dec:PackedStringArray=face_2[1].split("+")
					#if new_dec.size()>1:change_art_fade(c[0],new_dec[0],new_dec[1])
					#else:change_art_fade(c[0],new_dec[0],"")
					#print(c[0],":",decoration[0],">>",new_dec[0])	

	#对话框
	var default_character=null
	var dia:DialogueBox=null
	var is_4_cha:bool=true
	var selection:Selection=null
	match cmds[0][0]:
		"R":
			dia=DBOX_ROBOT.instantiate()
			#default_character=art_lin
		"青":
			dia=DBOX_CAT.instantiate()
			#default_character=art_cheng
		#"主":
			#dia=DIA_PLAYER.instantiate()
			#var player_face=characters[0].split("-")
			#dia.face=player_face[1]
			#is_4_cha=false
		#"旁":
			#dia=DIA_NARRATAGE.instantiate()
			#is_4_cha=false
		"选":
			selection=SELECTION.instantiate()
			var content=text.split("-")
			content.erase("")
			var s1:PackedStringArray=content[0].split("+")
			var s2:PackedStringArray=content[1].split("+")
			selection.str_selection_1=s1[0]
			selection.str_selection_2=s2[0]
			var offset_1=0
			if s1.size()>1:offset_1=s1[1].to_int()
			selection.select_1.connect(func():
				clear_dialogue_box()
				hide_all_characters()
				load_next_curtain(offset_1)
				)
			var offset_2=0
			if s2.size()>1:offset_2=s2[1].to_int()
			selection.select_2.connect(func():
				clear_dialogue_box()
				hide_all_characters()
				load_next_curtain(offset_2)
				)				
			%NodeDbox.add_child(selection)
		_:dia=DBOX.instantiate()

	if dia:
		#if is_4_cha:dia.pos=characters[0][1]
		var text_offset:PackedStringArray=text.split("+")
		var offset=0
		if text_offset.size()>1:offset=text_offset[1].to_int()
		#text_offset[0]=text_offset[0].replace("【主角】",Global.name_player)
		#找指令
		while (text_offset[0].find("【")!=-1):
			var order_start=text_offset[0].find("【")
			if order_start==-1:pass
			else:
				var order_end=text_offset[0].find("】")
				if order_end==-1:pass
				else:
					var length=order_end-order_start
					var code=text_offset[0].substr(order_start+1,length-1)
					var cmd_parameter:PackedStringArray=code.split("-")
					match cmd_parameter[0]:
						"场景":
							match cmd_parameter[1]:
								"黑屏幕":dia.process.push_back(func():switch_back_scene(SCENE_BLACK))
								"场景1_1":dia.process.push_back(func():switch_back_scene(SCENE_1_1))
								"场景1_2":dia.process.push_back(func():switch_back_scene(SCENE_1_2))
								"场景1_3":dia.process.push_back(func():switch_back_scene(SCENE_1_3))
								"场景2_1":dia.process.push_back(func():switch_back_scene(SCENE_2_1))
								"场景2_2":dia.process.push_back(func():switch_back_scene(SCENE_2_2))
								"场景3_1":dia.process.push_back(func():switch_back_scene(SCENE_3_1))
								"场景4_1":dia.process.push_back(func():switch_back_scene(SCENE_4_1))
								"场景5_1":dia.process.push_back(func():switch_back_scene(SCENE_5_1))
								"场景5_2":dia.process.push_back(func():switch_back_scene(SCENE_5_2))
								"场景5_3":dia.process.push_back(func():switch_back_scene(SCENE_5_3))
								"场景5_4":dia.process.push_back(func():switch_back_scene(SCENE_5_4))
								_:print("指令",cmd_parameter[0],"未知参数:",cmd_parameter[1])
						#"【问号感叹号】":dia.process.push_back(func():
							#default_character.dec问号感叹符号.emerge()
							#)
						#"【抖动上下】":dia.process.push_back(func():
							#default_character.ap_shake.play("v")
							#)
						#"【抖动左右】":dia.process.push_back(func():
							#default_character.ap_shake.play("h")
							#)
						#"【bgm_Routine2】":dia.process.push_back(func():
							#Global.fmod_switch_bgm("Routine2")
							#)
						_:print("未知指令:",cmd_parameter[0])
					text_offset[0]=text_offset[0].erase(order_start,length+1)
					text_offset[0]=text_offset[0].insert(order_start,"】")

		dia.arr_text=text_offset[0].split("//")
		dia.end.connect(func():
			clear_dialogue_box()
			hide_all_characters()
			load_next_curtain(offset)
			)
		%NodeDbox.add_child(dia)

func _ready() -> void:
	load_current_curtain()
