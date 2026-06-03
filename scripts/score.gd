extends Control

@onready var ScoreContent = $ScoreContent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$TextSpam.play("text_spam")
	$ScoreContent/AnimationPlayer.play("scorePopup")
	$ScoreContent/Label/AnimationPlayer.play("text_wobble")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_game_button_up() -> void:
	CharacterStats.emptyCharacterStats()
	GameManager.emptyAllGameManager()
	get_tree().change_scene_to_file("res://scenes/character_selection.tscn")


func _on_back_to_menu_button_up() -> void:
	CharacterStats.emptyCharacterStats()
	GameManager.emptyAllGameManager()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
