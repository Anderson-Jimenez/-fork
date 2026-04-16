extends Node

var nameChar;
var hp;
var maxHp;
var slots;
var money=50
var inv;

func setCharacter(char):
	nameChar=char["NAME"]
	hp=int(char["HP"])
	maxHp=int(char["HP"])
	slots=int(char["SLOTS"])
	inv=int(char["INV"])
