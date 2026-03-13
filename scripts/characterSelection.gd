extends Node

@onready var Portrait= $Panel2/HBoxContainer2/CharPortrait
@onready var CharName= $Panel2/HBoxContainer2/VBoxContainer/HBoxContainer/Name
@onready var CharHp= $Panel2/HBoxContainer2/VBoxContainer/HBoxContainer5/HP
@onready var CharSlots= $Panel2/HBoxContainer2/VBoxContainer/HBoxContainer4/Slots
@onready var CharInv= $Panel2/HBoxContainer2/VBoxContainer/HBoxContainer3/Inventori


var nameC
var hp
var slots
var inv

var characters = {
	char1={"NAME":"Anderson","HP":"100","SLOTS":"3","INV":"8"},
	char2={"NAME":"Pep","HP":"200","SLOTS":"2","INV":"6"},
	char3={"NAME":"Luciano","HP":"50","SLOTS":"4","INV":"4"},
	char4={"NAME":"Aptyp","HP":"10","SLOTS":"4","INV":"10"},
	char5={"NAME":"lepepeyt","HP":"150","SLOTS":"3","INV":"0"},
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func setParameters(characterName, characterHp, characterSlots, characterInv):
	nameC=characterName
	CharName.text=nameC
	
	hp=characterHp
	CharHp.text=hp
	
	slots=characterSlots
	CharSlots.text=slots
	
	inv=characterInv
	CharInv.text=inv


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/playScreen.tscn")
	
func _on_texture_button_char_1_pressed() -> void:
	setParameters(characters["char1"]["NAME"],characters["char1"]["HP"],characters["char1"]["SLOTS"],characters["char1"]["INV"])

func _on_texture_button_char_2_pressed() -> void:
	setParameters(characters["char2"]["NAME"],characters["char2"]["HP"],characters["char2"]["SLOTS"],characters["char2"]["INV"])


func _on_texture_button_char_3_pressed() -> void:
	setParameters(characters["char3"]["NAME"],characters["char3"]["HP"],characters["char3"]["SLOTS"],characters["char3"]["INV"])


func _on_texture_button_char_4_pressed() -> void:
	setParameters(characters["char4"]["NAME"],characters["char4"]["HP"],characters["char4"]["SLOTS"],characters["char4"]["INV"])


func _on_texture_button_char_5_pressed() -> void:
	setParameters(characters["char5"]["NAME"],characters["char5"]["HP"],characters["char5"]["SLOTS"],characters["char5"]["INV"])
