extends Control

@export var info : RandomEventData
@onready var CurrentStage = $ColorRect/Stage
@onready var Opcio1 = $ColorRect/ColorRect/ColorRect/Opcio1
@onready var Opcio2 = $ColorRect/ColorRect/ColorRect/Opcio2
@onready var Opcio3 = $ColorRect/ColorRect/ColorRect/Opcio3
@onready var Title = $ColorRect2/Title
@onready var Context = $ColorRect2/Context



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	info = load("res://data/events/event1.tres")
	CurrentStage.text=str(GameManager.currentStage)
	Opcio1.text = info.opcio1
	Opcio2.text = info.opcio2
	Opcio3.text = info.opcio3
	Title.text = info.name
	Context.text = info.context

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	GameManager.nextStage()
