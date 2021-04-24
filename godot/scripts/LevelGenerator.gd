extends Node

class BlockData:
	var obj: Object
	var x: int
	

export var LevelParts = []
export var LevelBlockWidth = 95
export var LevelWidthInBlocks = 40
export var LevelIndex = 0
export var LevelOffsetX: int = 0
export var LeveloffsetY: int = 300

var noise = OpenSimplexNoise.new()
var levelPart = load("res://level/LevelFlat1.tscn")
var player
var currentLoaded = []

var startX = -(LevelWidthInBlocks / 2)
var endX = LevelWidthInBlocks / 2

func _ready():
	noise.seed = randi()
	player = get_tree().get_nodes_in_group("player")[0]


func GetBlock(x):
	for b in currentLoaded:
		if b.x == x:
			return
		if b.x > LevelOffsetX + LevelWidthInBlocks:
			b.obj.queue_free()
			currentLoaded.erase(b)
			print("die")
		if b.x < LevelOffsetX - LevelWidthInBlocks:
			b.obj.queue_free()
			currentLoaded.erase(b)
			print("death")
		
	var d = levelPart.instance()
	d.transform.origin = Vector2(x * LevelBlockWidth + LevelOffsetX, LeveloffsetY)
	var blk = BlockData.new()
	blk.obj = d
	blk.x = x
	add_child(d)
	currentLoaded.append(blk)

func _process(delta):
	LevelOffsetX = int(round(player.position.x) / LevelBlockWidth)
	
	for i in range(startX + LevelOffsetX, endX + LevelOffsetX):
		GetBlock(i)
		
	pass
