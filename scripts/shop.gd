extends Control

@onready var CurrentStage = $ColorRect/Stage
@onready var CardContainer = $ColorRect2/CardsOnSale

var card_scene = preload("res://scenes/cardSceneShop.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrentStage.text=str(GameManager.currentStage)

	var cards = []
	var dir = DirAccess.open("res://resources/cards")

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var i=0;

		while file_name != "" and i<3:
			if file_name.ends_with(".tres"):
				var resource = load("res://resources/cards/" + file_name)
				if resource and resource.rarity == GameManager.currentStage:
					cards.append(resource)
					i+=1
			file_name = dir.get_next()

		dir.list_dir_end()

	print(cards)
	#print(character["CARDS"][0].name)
	for card in cards:
		var card_node = card_scene.instantiate()
		CardContainer.add_child(card_node)
	
		# Genera preu segons la raresa
		var preu = _generar_preu(card.rarity)
		card_node.setup(card, preu)
		
		card_node.card_clicked.connect(func(card_data, p): _on_card_clicked(card_data, p, card_node))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_card_clicked(card_data, preu, card_node):
	print(preu)
	print(CharacterStats.money)
	if CharacterStats.money >= preu:
		CharacterStats.money+=-preu
		CharacterStats.cards.append(card_data)
		card_node.comprar()
	else:
		print("No tens la money")


func _on_button_up_next_stage() -> void:
	GameManager.nextStage()
	
func _generar_preu(rarity: int) -> int:
	match rarity:
		1: return randi_range(50, 100)
		2: return randi_range(100, 200)
		3: return randi_range(200, 400)
		_: return 50
