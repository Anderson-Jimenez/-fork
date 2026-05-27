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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrentStage.text=str(GameManager.currentStage)
	
	var resourceFiles = DirAccess.get_files_at("res://resources/enemies/")
	var randomResource = resourceFiles[randi() % resourceFiles.size()]
	
	enemy = load("res://resources/enemies/"+randomResource)
	EnemySprite.texture = load(enemy.sprite)
	EnemyHp.text= str(enemy.hp)
	EnemyMaxHp.text = str(enemy.maxHp)
	EnemyName.text = enemy.name
	
	print(enemy)
	
	Sprite.texture = load("res://images/test.png")
	Hp.text= str(CharacterStats.hp)
	MaxHp.text = str(CharacterStats.maxHp)
	CharacterName.text = CharacterStats.nameChar


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
