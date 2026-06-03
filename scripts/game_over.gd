extends Control

@onready var quantity = $HBoxContainer/Quantitat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var value = (GameManager.currentWindow / 30.0) * 100
	quantity.text = str(int(value))
	
	$ScoreContent/AnimationPlayer.play("scorePopup")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_to_menu_button_up() -> void:
	CharacterStats.emptyCharacterStats()
	GameManager.emptyAllGameManager()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_new_game_button_up() -> void:
	CharacterStats.emptyCharacterStats()
	GameManager.emptyAllGameManager()
	get_tree().change_scene_to_file("res://scenes/character_selection.tscn")
