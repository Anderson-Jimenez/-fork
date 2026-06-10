extends Resource
class_name EnemyData

@export var name: String = ""
@export var hp: int = 10
@export var maxHp: int = 10
@export var sprite: Texture = null
@export var passiveDmg: int = 1            # daño del ataque básico
@export var cards: Array[Resource] = []   # <--- Tipado a Array de Resource
@export var enemyStage: int = 1
@export var passiveSlots: Array = []
