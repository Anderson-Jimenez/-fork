extends Control

@onready var CurrentStage = $ColorRect/Stage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrentStage.text=str(GameManager.currentStage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_up_next_stage() -> void:
	GameManager.nextStage()
