extends Node

var hp: int = 0
var maxHp: int = 0
var cards: Array = []
var passiveDmg: int = 0
var sprite: Texture

func setEnemy(data: EnemyData):
	name = data.name
	hp = data.hp
	maxHp = data.maxHp
	cards = data.cards.duplicate(true) if data.cards else []
	passiveDmg = data.passiveDmg
	sprite = data.sprite
	# (puedes añadir más campos si los necesitas)
