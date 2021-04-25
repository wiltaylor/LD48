extends Node

class LevelData:
	var obj: Object
	var y: int

export var LevelsToLoadAround = 3

var levelGap = 300
var LevelBlockWidth = 95
var LevelGeneratorPrefab = load("res://level/LevelGenerator.tscn")
var player
var noise = OpenSimplexNoise.new()
var WorldOffsetX: int = 0
var WorldOffsetY: int = 0
var currentLoaded = []

func GetLevel(y):
	for level in currentLoaded:
		if level.y == y:
			return
		if level.y < WorldOffsetY - LevelsToLoadAround:
			level.obj.queue_free()
			currentLoaded.erase(level)
		if level.y > WorldOffsetY + LevelsToLoadAround:
			level.obj.queue_free()
			currentLoaded.erase(level)
			
		
	var d = LevelGeneratorPrefab.instance()
	d.LeveloffsetY = levelGap * y
	add_child(d)
	
	var ld = LevelData.new()
	ld.y = y
	ld.obj = d
	currentLoaded.append(ld)

func _ready():
	noise.seed = randi()
	player = get_tree().get_nodes_in_group("player")[0]

func _process(delta):
	WorldOffsetX = int(round(player.position.x) / LevelBlockWidth)
	WorldOffsetY = int(round(player.position.y) / levelGap)
	
	for i in range(WorldOffsetY - LevelsToLoadAround, WorldOffsetY + LevelsToLoadAround):
		GetLevel(i)
