extends Node

@onready var CardContainer = $ColorRect/Inventory/HBoxContainer
var card_scene = preload("res://scenes/cardScene.tscn")

func _ready():
	var character = CharacterStats.getCharacter()
	print(character)
	for card in character["CARDS"]:
		var card_node = card_scene.instantiate()
		CardContainer.add_child(card_node)
		card_node.setup(card)


func _on_button_button_up() -> void:
	GameManager.nextStage()
