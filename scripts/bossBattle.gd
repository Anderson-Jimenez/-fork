extends Control

@onready var CurrentStage = $ColorRect/Stage

var enemy;
var enemies: Array[EnemyData] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrentStage.text=str(GameManager.currentStage)
	
	load_enemies()
	enemy=get_random_enemy()
	
	print(enemy.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_up_next_stage() -> void:
	GameManager.currentStage+=1
	GameManager.totalStages+=1
	GameManager.nextStage()

func load_enemies():
	var path = "res://resources/enemies/stage"+str(GameManager.currentStage)+"/bosses/"
	var dir = DirAccess.open(path)
	if not dir:
		return
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while file_name != "":
		if file_name.ends_with(".tres"):
			var resource = load(path + file_name)
			enemies.append(resource)
		file_name = dir.get_next()
	
	dir.list_dir_end()


func get_random_enemy() -> EnemyData:
	return enemies[randi() % enemies.size()]
