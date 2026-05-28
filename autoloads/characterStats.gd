extends Node

var nameChar;
var hp;
var maxHp;
var slots;
var money=50
var inv;
var sprite;
var cards = [];

func setCharacter(char):
	nameChar=char["NAME"]
	hp=int(char["HP"])
	maxHp=int(char["HP"])
	slots=int(char["SLOTS"])
	inv=int(char["INV"])
	sprite=char["SPRITE"]
	cards = char["CARDS"] 

func emptyCharacterStats():
	nameChar;
	hp;
	maxHp;
	slots;
	money=50;
	inv;
	sprite;
	cards = [];
	
func getCharacter():
	return {
		"NAME": nameChar,
		"HP": hp,
		"MAX_HP": maxHp,
		"SLOTS": slots,
		"MONEY": money,
		"INV": inv,
		"SPRITE": sprite,
		"CARDS": cards
	}
