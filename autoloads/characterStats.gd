extends Node

var nameChar
var maxHp: int=100
var hp: int = 100 :
	set(valor):
		hp = clampi(valor, 0, maxHp)
		
var slots = []
var money: int = 50 :
	set(valor):
		money = maxi(valor, 0)
		
var sprite
var startingHand
var cards = []

var cardActivated = 0
var dmgRecived = 0
var dmgDealed = 0


func gameOver():
	if hp==0:
		get_tree().change_scene_to_file("res://scenes/score.tscn")

func setCharacter(char):
	nameChar = char["NAME"]
	maxHp = int(char["HP"])
	hp = int(char["HP"])
	slots = [null, null, null, null]
	sprite = char["SPRITE"]
	startingHand = char["SARTING_HAND"]
	cards = char["CARDS"]

func setStartingCards():
	var results = []
	var dir = DirAccess.open("res://resources/cards")
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			if file_name.ends_with(".tres"):
				var resource = load("res://resources/cards/" + file_name)
				if resource and resource.rarity == startingHand:
					results.append(resource)
			file_name = dir.get_next()
		
		dir.list_dir_end()
		
	cards=results

func emptyCharacterStats():
	nameChar;
	hp;
	maxHp;
	slots = [];
	money=50;
	sprite;
	cards = [];
	
func getCharacter():
	return {
		"NAME": nameChar,
		"HP": hp,
		"MAX_HP": maxHp,
		"SLOTS": slots,
		"MONEY": money,
		"SPRITE": sprite,
		"CARDS": cards
	}
