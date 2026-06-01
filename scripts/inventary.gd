extends Node

@onready var CardContainer = $ColorRect/Inventory/HBoxContainer
@onready var characterIdle = $ColorRect/Character
@onready var slot1 = $ColorRect/Slot1/cardN
@onready var slot2 = $ColorRect/Slot2/cardN
@onready var slot3 = $ColorRect/Slot3/cardN
@onready var slot4 = $ColorRect/Slot4/cardN
@onready var selectedCard = $ColorRect/SelectedCard/cInfo

var card_scene = preload("res://scenes/cardScene.tscn")

var currentSelectedCard = {}

func _ready():
	var character = CharacterStats.getCharacter()
	for card in character["CARDS"]:
		var card_node = card_scene.instantiate()
		CardContainer.add_child(card_node)
		card_node.setup(card)
		card_node.card_clicked.connect(_on_card_clicked)
	characterIdle.texture = load(character["SPRITE"])
	


func _on_button_button_up() -> void:
	GameManager.nextStage()

func _on_card_clicked(card_data):
	currentSelectedCard = card_data
	selectedCard.text = card_data["NAME"] + "\n" + card_data["TYPE"] + "\n" + card_data["DESC"]


#===================================================================#
#               Assignacions de cartes a slots                      #
#===================================================================#

func _on_move_to_slot_1_pressed() -> void:
	CharacterStats.slots[0] = currentSelectedCard
	slot1.text = currentSelectedCard["NAME"]
	print(CharacterStats.slots[0])


func _on_move_to_slot_2_pressed() -> void:
	CharacterStats.slots[1] = currentSelectedCard
	slot2.text = currentSelectedCard["NAME"]
	print(CharacterStats.slots[1])


func _on_move_to_slot_3_pressed() -> void:
	CharacterStats.slots[2] = currentSelectedCard
	slot3.text = currentSelectedCard["NAME"]
	print(CharacterStats.slots[2])

func _on_move_to_slot_4_pressed() -> void:
	CharacterStats.slots[3] = currentSelectedCard
	slot4.text = currentSelectedCard["NAME"]
	print(CharacterStats.slots[3])
