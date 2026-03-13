extends Control

@onready var CharName= $Label/VBoxContainer/HBoxContainer/Name
@onready var CharHp= $Label/VBoxContainer/HBoxContainer5/HP
@onready var CharSlots= $Label/VBoxContainer/HBoxContainer4/Slots
@onready var CharInv= $Label/VBoxContainer/HBoxContainer3/Inventori



	
func showStats(name,hp,slots,inv) -> void:
	CharName.text = str(name)
	CharHp.text = str(hp)
	CharSlots.text = str(slots)
	CharInv.text = str(inv)




func _ready() -> void:
	var char = GameManager.selectedCharacter
	showStats(char["NAME"],char["HP"],char["SLOTS"],char["INV"])
	
