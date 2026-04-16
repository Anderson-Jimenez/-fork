extends Control

@export var info : RandomEventData
@onready var CurrentStage = $ColorRect/Stage
@onready var Opcio1 = $ColorRect/Responses/Opcio1
@onready var Opcio2 = $ColorRect/Responses/Opcio2
@onready var Opcio3 = $ColorRect/Responses/Opcio3

@onready var HP = $ColorRect/VBoxContainer/HBoxContainer/HP
@onready var MaxHP = $ColorRect/VBoxContainer/HBoxContainer/maxHP
@onready var Money = $ColorRect/VBoxContainer/HBoxContainer2/Money
@onready var NameChar = $ColorRect/VBoxContainer/Name

@onready var Title = $ColorRect/ColorRect4/Title
@onready var Context = $ColorRect/ColorRect4/Context


@onready var hp

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Agafo Carpeta amb random events
	var dir = DirAccess.open("res://scripts/randomEvent")
	
	#Agafo tots els arxius
	if dir:
		dir = dir.get_files()
	else:
		print("Error: No s'ha pogut obrir la carpeta.")
	
	#Els compto i esculleixo un aleatori
	var event = rng.randi_range(1, dir.size())
	print(event)
	
	#Carrego el event escollit aleatoriament
	info = load("res://scripts/randomEvent/event"+str(event)+".tres")
	CurrentStage.text=str(GameManager.currentStage)
	Opcio1.text = info.opcio1
	Opcio2.text = info.opcio2
	Opcio3.text = info.opcio3
	Title.text = info.name
	Context.text = info.context
	
	#Carregar info del personatge
	NameChar.text = CharacterStats.nameChar
	HP.text = str(CharacterStats.hp)
	MaxHP.text = str(CharacterStats.maxHp)
	Money.text = str(CharacterStats.money)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Trucar la funcio especifica del event al clicar una de les opcions
func _on_opcio_1_button_up() -> void:
	info.call(info.opcio1Value)
	
func _on_opcio_2_button_up() -> void:
	info.call(info.opcio2Value)
	
func _on_opcio_3_button_up() -> void:
	info.call(info.opcio3Value)
