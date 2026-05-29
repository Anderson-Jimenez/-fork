extends Control

@onready var CurrentStage = $ColorRect/Stage

@onready var EnemySprite = $ColorRect/EnemyArea/enemySprite
@onready var EnemyHp = $ColorRect/EnemyArea/HBoxContainer/enemyHp
@onready var EnemyMaxHp = $ColorRect/EnemyArea/HBoxContainer/enemyMaxHp
@onready var EnemyName = $ColorRect/EnemyArea/enemyName

@onready var Sprite = $ColorRect/CharacterArea/characterSprite
@onready var Hp = $ColorRect/CharacterArea/HBoxContainer/hp
@onready var MaxHp = $ColorRect/CharacterArea/HBoxContainer/maxHp
@onready var CharacterName = $ColorRect/CharacterArea/characterName

@onready var timer = $BattleTimer
@onready var TimerLabel = $ColorRect/Time

@onready var basicTime = $BasicAttackTimer
@onready var BasicAttackProgress = $ColorRect/EnemyArea/BasicAttackProgress

var enemy;
var enemies: Array[EnemyData] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrentStage.text=str(GameManager.currentWindow)
	
	var resourceFiles = DirAccess.get_files_at("res://resources/enemies/")
	var randomResource = resourceFiles[randi() % resourceFiles.size()]
	load_enemies()
	enemy=get_random_enemy()
	
	EnemySprite.texture = enemy.sprite
	EnemyHp.text= str(enemy.hp)
	EnemyMaxHp.text = str(enemy.maxHp)
	EnemyName.text = enemy.name
	
	print(enemy)
	
	Sprite.texture = load("res://images/test.png")
	Hp.text= str(CharacterStats.hp)
	MaxHp.text = str(CharacterStats.maxHp)
	CharacterName.text = CharacterStats.nameChar



func load_enemies():
	var path = "res://resources/enemies/stage"+str(GameManager.currentStage)+"/basicEnemies/"
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var remainingTime = timer.time_left
	TimerLabel.text = str(round(remainingTime))
	
	var basicAttackTime = basicTime.time_left
	BasicAttackProgress.value = basicAttackTime

func _on_button_up_next_stage() -> void:
	GameManager.nextStage()


func _on_basic_attack_timer_timeout() -> void:
	CharacterStats.hp = CharacterStats.hp - enemy.passiveDmg
	Hp.text = str(CharacterStats.hp)
