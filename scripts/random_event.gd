extends Control

@export var info : RandomEventData
var eventFunction
var eventResponse

@onready var CurrentWindow = $ColorRect/Stage
@onready var CurrentStage = $Stage2

@onready var Opcio1 = $ColorRect/Responses/Opcio1
@onready var Opcio2 = $ColorRect/Responses/Opcio2
@onready var Opcio3 = $ColorRect/Responses/Opcio3
@onready var NextStage = $ColorRect/Responses/NextStage

@onready var HP = $ColorRect/VBoxContainer/HBoxContainer/HP
@onready var MaxHP = $ColorRect/VBoxContainer/HBoxContainer/maxHP
@onready var Money = $ColorRect/VBoxContainer/HBoxContainer2/Money
@onready var NameChar = $ColorRect/VBoxContainer/Name
@onready var charSprite = $ColorRect/Character
@onready var Title = $ColorRect/ColorRect4/Title
@onready var Context = $ColorRect/ColorRect4/Context


@onready var hp

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Agafo arxiu d'event aleatori
	var stagePath = "res://resources/randomEvent/stage"+ str(GameManager.currentStage)
	var resourceFiles = DirAccess.get_files_at(stagePath)
	
	var randomResource = resourceFiles[randi() % resourceFiles.size()]
	var fullPath = stagePath + "/" + randomResource
	
	#Carrego el event escollit aleatoriament
	info = load(fullPath)
	eventFunction = Callable(RandomEvents, info.id)

	CurrentWindow.text=str(GameManager.currentWindow)
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
	charSprite.texture = load(CharacterStats.sprite)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Trucar la funcio especifica del event al clicar una de les opcions
func _on_opcio_1_button_up() -> void:
	if info.opcio1Value==1:
		eventResponse = eventFunction.call(int(info.opcio1Value))
		Context.text = eventResponse
		onOptionHide()
	else:
		pass
	
func _on_opcio_2_button_up() -> void:
	if info.opcio2Value==2:
		eventResponse = eventFunction.call(int(info.opcio2Value))
		Context.text = eventResponse
		onOptionHide()
	else:
		pass
		
func _on_opcio_3_button_up() -> void:
	if info.opcio3Value==3:
		eventResponse = eventFunction.call(int(info.opcio3Value))
		Context.text = eventResponse
		onOptionHide()
	else:
		pass
	
	
func onOptionHide():
	Opcio1.visible = false
	Opcio2.visible = false
	Opcio3.visible = false
	NextStage.visible = true


func _on_next_stage_button_up() -> void:
	GameManager.nextStage()
