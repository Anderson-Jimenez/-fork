extends Control

@onready var CharName= $Label/VBoxContainer/HBoxContainer/Name
@onready var CharHp= $Label/VBoxContainer/HBoxContainer5/HP
@onready var CharSlots= $Label/VBoxContainer/HBoxContainer4/Slots
@onready var CharInv= $Label/VBoxContainer/HBoxContainer3/Inventori

	
func showStats(name,hp,slots,inv) -> void:
	CharName.text = name
	CharHp.text = hp
	CharSlots.text = slots
	CharInv.text = inv


func _ready() -> void:
	var characterConditions = FuncionsCondicions.obtainRandomFunction()
	print(characterConditions)
	print(FuncionsCondicions.call(characterConditions[1]))
	
	GameManager.routeGenerator()
	print(GameManager.stages)
	
	showStats(CharacterStats.nameChar,str(CharacterStats.hp),str(CharacterStats.slots),str(CharacterStats.inv))
	


func _on_button_up_next_stage() -> void:
	GameManager.nextStage()
