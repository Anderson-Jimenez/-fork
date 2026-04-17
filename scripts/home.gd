extends Control

@onready var CharName= $Label/VBoxContainer/HBoxContainer/Name
@onready var CharHp= $Label/VBoxContainer/HBoxContainer5/HP
@onready var CharSlots= $Label/VBoxContainer/HBoxContainer4/Slots
@onready var CharInv= $Label/VBoxContainer/HBoxContainer3/Inventori
@onready var CharSprite = $TextureRect
	


func _ready() -> void:
	var characterConditions = FuncionsCondicions.obtainRandomFunction()
	print(characterConditions)
	print(FuncionsCondicions.call(characterConditions[1]))
	
	GameManager.routeGenerator()
	print(GameManager.stages)
	
	#CharName.text = CharacterStats.nameChar
	#CharHp.text = str(CharacterStats.hp)
	#CharSlots.text = str(CharacterStats.slots)
	#CharInv.text = str(CharacterStats.inv)
	#CharSprite.texture = load(CharacterStats.sprite)



func _on_button_up_next_stage() -> void:
	GameManager.nextStage()
