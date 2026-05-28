extends Node

@onready var CardContainer = $ScrollContainer/VBoxContainer
var card_scene = preload("res://scenes/cardScene.tscn")

func _ready():
	var character = CharacterStats.getCharacter()
	for card in character["CARDS"]:
		var card_node = card_scene.instantiate()
		card_node.get_node("CardName").text = card["NAME"]
		card_node.get_node("CardType").text = card["TYPE"]
		card_node.get_node("CardDesc").text = card["DESC"]
		CardContainer.add_child(card_node)
