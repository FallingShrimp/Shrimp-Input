extends Control
class_name ExampleShrimpUI

const quotes = [
	{
		"quote": "胜利属于坚持到最后的人。",
		"author": "拿破仑"
	},
	{
		"quote": "理想的书籍是智慧的钥匙。",
		"author": "列夫·托尔斯泰"
	},
	{
		"quote": "生命不等于是呼吸,生命是活动。",
		"author": "卢梭"
	},
	{
		"quote": "凡是自强不息者,最终都会成功。",
		"author": "歌德"
	},
	{
		"quote": "只要朝着阳光,便不会看见阴影。",
		"author": "海伦凯勒"
	},
	{
		"quote": "不要努力去做一个成功的人,而应该努力去做一个有价值的人。",
		"author": "阿尔伯特·爱因斯坦"
	},
	{
		"quote": "你的时间有限,所以别浪费生命过别人的生活。",
		"author": "史蒂夫·乔布斯"
	},
	{
		"quote": "重要的不是你活了多少年,而是你活出的生命有多少分量。",
		"author": "亚伯拉罕·林肯"
	},
	{
		"quote": "始终面向阳光,阴影就会自然地落到你身后。",
		"author": "沃尔特·惠特曼"
	},
	{
		"quote": "我了解到,人们会忘记你说过的话,忘记你做过的事,但永远不会忘记你给他们的感受。",
		"author": "玛雅·安吉罗"
	},
	{
		"quote": "唯有真理,才是我该誓死捍卫的。",
		"author": "卡特赖特"
	},
	{
		"quote": "耐心和持久胜于激烈的狂热。",
		"author": "拉封丹"
	},
	{
		"quote": "被克服的困难就是胜利的契机。",
		"author": "丘吉尔"
	},
	{
		"quote": "劳动创造世界。",
		"author": "马克思"
	},
	{
		"quote": "生活本身就是一个最美丽的童话!",
		"author": "安徒生"
	},
	{
		"quote": "人不是仅仅为了爱而生存的;难道男人的全部目标就是为了控制某一个女子,而女子的全部目标就是为了左右某一个男子吗?从来不是!",
		"author": "赫尔岑"
	},
	{
		"quote": "过去属于死神,未来属于自己。",
		"author": "雪莱"
	},
	{
		"quote": "最穷的是无才,最贱的是无志。",
		"author": "福楼拜"
	},
	{
		"quote": "独立之精神,自由之思想。",
		"author": "陈寅恪"
	},
	{
		"quote": "钢是在烈火和急剧冷却里锻炼出来的,所以才能坚硬和什么也不怕。",
		"author": "奥斯特洛夫斯基"
	}
]


static var instance: ExampleShrimpUI

@onready var levelAnimator: AnimationPlayer = $%LevelAnimator
@onready var levelLabel: Label = $%Level
@onready var buffAnimator: AnimationPlayer = $%BuffAnimator
@onready var buffLabel: Label = $%Buff
@onready var buffNotice: Control = $%BuffNotice
@onready var waveTip: Label = $%Wave
@onready var buffBox: StyleBoxFlat
@onready var quoteLabel: Label = $%Quote
@onready var authorLabel: Label = $%Author
@onready var currentScoreLabel: Label = $%CurrentScore
@onready var maxScoreLabel: Label = $%MaxScore
@onready var scoreProgress: ProgressBar = $%ScoreProgress
@onready var lvLabel: Label = $%Lv
var score: float = 0
var scoredTimes: int = 0
var rewardMax: float:
	get:
		return 200 + scoredTimes * 300

func _ready() -> void:
	instance = self
	buffBox = buffNotice.get_theme_stylebox("panel")
	addScore(0, get_tree().root)
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused

static func addScore(amount: float, where: Node):
	var player = where.get_tree().get_nodes_in_group("player")[0] as ExampleShrimpPlayer
	instance.score += amount * (1 + player.lucky * 0.04) * player.scoreMult
	while instance.score >= instance.rewardMax:
		instance.score -= instance.rewardMax
		instance.scoredTimes += 1
		for i in randi_range(1, 2):
			ExampleShrimpBuffBall.reward(where, player.position + Vector2.from_angle(randf() * TAU) * randf_range(50, 200))
	instance.currentScoreLabel.text = "%d" % instance.score
	instance.maxScoreLabel.text = "%d" % instance.rewardMax
	instance.scoreProgress.max_value = instance.rewardMax
	instance.scoreProgress.value = instance.score
	instance.lvLabel.text = "Lv.%d" % instance.scoredTimes
static func buff(tip: String, color: Color):
	color.a *= 0.6
	instance.buffBox.bg_color = color
	instance.buffLabel.text = tip
	instance.buffAnimator.stop()
	instance.buffAnimator.play("buff")
static func level(count: int):
	var quote = quotes.pick_random()
	instance.quoteLabel.text = quote.quote
	instance.authorLabel.text = "—— %s" % quote.author
	instance.waveTip.text = str(count)
	instance.levelLabel.text = str(count)
	instance.levelAnimator.play("level")
