extends Control

@onready var quantity = $HBoxContainer/Quantitat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quantity.text=str(GameManager.currentWindow/100*30)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	GameManager.emptyAllGameManager()
	CharacterStats.emptyCharacterStats()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
