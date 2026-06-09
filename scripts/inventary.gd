extends Node
@onready var CardContainer = $ColorRect/Inventory/HBoxContainer
@onready var characterIdle = $ColorRect/Character
@onready var slot1 = $ColorRect/Slot1/cardN
@onready var slot2 = $ColorRect/Slot2/cardN
@onready var slot3 = $ColorRect/Slot3/cardN
@onready var slot4 = $ColorRect/Slot4/cardN
@onready var selectedCardName = $ColorRect/SelectedCard/cName
@onready var selectedCardDesc = $ColorRect/SelectedCard/cDesc
var card_scene = preload("res://scenes/cardScene.tscn")
var currentSelectedCard = {}
var cardNodes = {}

func _ready():
	var character = CharacterStats.getCharacter()
	for card in character["CARDS"]:
		var card_node = card_scene.instantiate()
		CardContainer.add_child(card_node)
		card_node.setup(card)
		card_node.card_clicked.connect(_on_card_clicked)
		cardNodes[card["name"]] = card_node
	characterIdle.texture = load(character["SPRITE"])

	$ColorRect/Slot1.gui_input.connect(_on_slot_input.bind(0, slot1))
	$ColorRect/Slot2.gui_input.connect(_on_slot_input.bind(1, slot2))
	$ColorRect/Slot3.gui_input.connect(_on_slot_input.bind(2, slot3))
	$ColorRect/Slot4.gui_input.connect(_on_slot_input.bind(3, slot4))

func _on_slot_input(event, slot_index, slot_label):
	if event is InputEventMouseButton and event.double_click and CharacterStats.slots[slot_index] != null:
		var card = CharacterStats.slots[slot_index]
		cardNodes[card["name"]].visible = true
		CharacterStats.slots[slot_index] = null
		slot_label.text = ""

func _assign_to_slot(slot_index, slot_label):
	if currentSelectedCard == null:
		selectedCardDesc.text = "No tienes ninguna \n carta seleccionada!"
	else:
		CharacterStats.slots[slot_index] = currentSelectedCard
		slot_label.text = currentSelectedCard["name"]
		cardNodes[currentSelectedCard["name"]].visible = false
		currentSelectedCard = null
		selectedCardName.text = ""
		selectedCardDesc.text = ""
		print(CharacterStats.slots[slot_index])
func _on_button_button_up() -> void:
	GameManager.nextStage()

func _on_card_clicked(card_data):
	currentSelectedCard = card_data
	selectedCardName.text = card_data["name"]
	selectedCardDesc.text = card_data["description"]

func _on_move_to_slot_1_pressed() -> void:
	_assign_to_slot(0, slot1)
func _on_move_to_slot_2_pressed() -> void:
	_assign_to_slot(1, slot2)
func _on_move_to_slot_3_pressed() -> void:
	_assign_to_slot(2, slot3)
func _on_move_to_slot_4_pressed() -> void:
	_assign_to_slot(3, slot4)
