extends Node

@onready var Portrait = $Panel2/HBoxContainer2/CharPortrait
@onready var CharName = $Panel2/HBoxContainer2/VBoxContainer/HBoxContainer/Name
@onready var CharHp = $Panel2/HBoxContainer2/VBoxContainer/HBoxContainer5/HP
@onready var CharSlots = $Panel2/HBoxContainer2/VBoxContainer/HBoxContainer4/Slots
@onready var CharInv = $Panel2/HBoxContainer2/VBoxContainer/HBoxContainer3/Inventori


var selectedCharacter = {}

var characters = {
	"char1": {
		"NAME": "Anderson",
		"HP": "100",
		"SLOTS": [{}, {}, {}, {}],
		"SPRITE": "res://images/test.png",
		"SARTING_HAND": 11,
		"CARDS": []
	},

	"char2": {
		"NAME": "Pep",
		"HP": "200",
		"SLOTS": [{}, {}, {}, {}],
		"SPRITE": "res://images/template.png",
		"SARTING_HAND": 12,
		"CARDS": []
	},

	"char3": {
		"NAME": "Luciano",
		"HP": "50",
		"SLOTS": [{}, {}, {}, {}],
		"SPRITE": "res://images/test.png",
		"SARTING_HAND": 13,
		"CARDS": []
	},

	"char4": {
		"NAME": "Aptyp",
		"HP": "10",
		"SLOTS": [{}, {}, {}, {}],
		"SPRITE": "res://images/template.png",
		"CARDS": []
	},

	"char5": {
		"NAME": "lepepeyt",
		"HP": "150",
		"SLOTS": [{}, {}, {}, {}],
		"SPRITE": "res://images/test.png",
		"CARDS": []
	}
}


func show_character(id):
	selectedCharacter = characters[id]

	CharName.text = selectedCharacter["NAME"]
	CharHp.text = selectedCharacter["HP"]
	CharSlots.text = "4"

	Portrait.texture = load(selectedCharacter["SPRITE"])

func _on_start_game_pressed() -> void:
	CharacterStats.setCharacter(selectedCharacter)
	CharacterStats.setStartingCards()
	GameManager.routeGenerator()
	GameManager.setCharacter(selectedCharacter)
	get_tree().change_scene_to_file("res://scenes/inventary.tscn")


func _on_texture_button_char_1_pressed() -> void:
	show_character("char1")


func _on_texture_button_char_2_pressed() -> void:
	show_character("char2")


func _on_texture_button_char_3_pressed() -> void:
	show_character("char3")


func _on_texture_button_char_4_pressed() -> void:
	show_character("char4")


func _on_texture_button_char_5_pressed() -> void:
	show_character("char5")
