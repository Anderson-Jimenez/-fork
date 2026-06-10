extends Control

@onready var CurrentWindow = $ColorRect/Stage

@onready var EnemySprite = $ColorRect/EnemyArea/enemySprite
@onready var EnemyHp = $ColorRect/EnemyArea/HBoxContainer/enemyHp
@onready var EnemyMaxHp = $ColorRect/EnemyArea/HBoxContainer/enemyMaxHp
@onready var EnemyName = $ColorRect/EnemyArea/enemyName

@onready var Sprite = $ColorRect/CharacterArea/characterSprite
@onready var Hp = $ColorRect/CharacterArea/HBoxContainer/hp
@onready var MaxHp = $ColorRect/CharacterArea/HBoxContainer/maxHp
@onready var CharacterName = $ColorRect/CharacterArea/characterName

@onready var CardArea = $ColorRect/CharacterArea/CardArea
@onready var slot1 = $ColorRect/CharacterArea/CardArea/slot1
@onready var slot2 = $ColorRect/CharacterArea/CardArea/slot2
@onready var slot3 = $ColorRect/CharacterArea/CardArea/slot3
@onready var slot4 = $ColorRect/CharacterArea/CardArea/slot4

@onready var slot1L = $ColorRect/CharacterArea/CardArea/slot1/Label
@onready var slot2L = $ColorRect/CharacterArea/CardArea/slot2/Label
@onready var slot3L = $ColorRect/CharacterArea/CardArea/slot3/Label
@onready var slot4L = $ColorRect/CharacterArea/CardArea/slot4/Label

@onready var timer = $BattleTimer
@onready var TimerLabel = $ColorRect/Time
@onready var basicTime = $BasicAttackTimer
@onready var BasicAttackProgress = $ColorRect/EnemyArea/BasicAttackProgress

var card_scene = preload("res://scenes/cardScene.tscn")

var enemy: EnemyData
var enemies: Array[EnemyData] = []

# Variables para efectos especiales
var slot_cooldowns = []               # para cartas tipo "time"
var setze_timer: Timer                # para idSetze (daño creciente)
var setze_damage: float = 0.5
var divuit_timer: Timer               # para idDivuit (muerte a los 59s)
var quinze_used: bool = false         # para idQuinze (una sola vez)

func _ready() -> void:
	CurrentWindow.text = str(GameManager.currentWindow)
	
	load_enemies()
	enemy = get_random_enemy()
	
	EnemySprite.texture = enemy.sprite
	EnemyHp.text = str(enemy.hp)
	EnemyMaxHp.text = str(enemy.maxHp)
	EnemyName.text = enemy.name
	
	# Mostrar cartas en los slots
	slot1L.text = CharacterStats.slots[0].name if CharacterStats.slots[0] else "No Card"
	slot2L.text = CharacterStats.slots[1].name if CharacterStats.slots[1] else "No Card"
	slot3L.text = CharacterStats.slots[2].name if CharacterStats.slots[2] else "No Card"
	slot4L.text = CharacterStats.slots[3].name if CharacterStats.slots[3] else "No Card"
	
	# Configurar cartas de tipo "time" (barras de progreso)
	_card_type_time()
	
	# Configurar efectos especiales (temporizadores únicos)
	_setup_special_timers()
	
	# UI del personaje
	Sprite.texture = load("res://images/test.png")
	Hp.text = str(CharacterStats.hp)
	MaxHp.text = str(CharacterStats.maxHp)
	CharacterName.text = CharacterStats.nameChar

func load_enemies() -> void:
	var path = "res://resources/enemies/stage" + str(GameManager.currentStage) + "/basicEnemies/"
	var dir = DirAccess.open(path)
	if not dir:
		return
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if file_name.ends_with(".tres"):
			var resource = load(path + file_name)
			enemies.append(resource)
		file_name = dir.get_next()
	dir.list_dir_end()

func get_random_enemy() -> EnemyData:
	return enemies[randi() % enemies.size()]

func _process(delta: float) -> void:
	if CharacterStats.hp <= 0:
		get_tree().change_scene_to_file("res://scenes/gameOver.tscn")
		return
	
	var remainingTime = timer.time_left
	TimerLabel.text = str(round(remainingTime))
	
	var basicAttackTime = basicTime.time_left
	BasicAttackProgress.value = basicAttackTime
	
	# Actualizar cooldowns de cartas tipo "time"
	for cd in slot_cooldowns:
		if cd.active:
			cd.remaining -= delta
			cd.bar.value = cd.remaining
			if cd.remaining <= 0:
				_apply_time_card_effect(cd.card, cd.slot_index)
				cd.remaining = cd.total

func _card_type_time() -> void:
	for i in range(4):
		var slot_node = [slot1, slot2, slot3, slot4][i]
		var card = CharacterStats.slots[i]
		
		var bar = ProgressBar.new()
		bar.name = "CooldownBar_" + str(i)
		bar.size = Vector2(80, 12)
		bar.position = Vector2(10, 90)
		bar.visible = false
		bar.show_percentage = false
		slot_node.add_child(bar)
		
		if card and card.type == "time":
			var cooldown_total = card.get("cooldown")
			bar.visible = true
			bar.max_value = cooldown_total
			bar.value = cooldown_total
			slot_cooldowns.append({
				"bar": bar,
				"remaining": cooldown_total,
				"total": cooldown_total,
				"active": true,
				"card": card,
				"slot_index": i
			})
		else:
			slot_cooldowns.append({
				"bar": bar,
				"remaining": 0,
				"total": 0,
				"active": false,
				"card": null,
				"slot_index": i
			})

func _setup_special_timers() -> void:
	
	# idSetze (16): daño creciente cada 3 segundos (0.5, 1, 2, 4...)
	if _is_card_equipped_by_id("idSetze"):
		setze_timer = Timer.new()
		setze_timer.wait_time = 3.0
		setze_timer.timeout.connect(_apply_setze_effect)
		add_child(setze_timer)
		setze_timer.start()
		_apply_setze_effect()  # primer daño inmediato

func _apply_setze_effect() -> void:
	if setze_damage <= 0:
		return
	apply_damage_to_enemy(setze_damage, "idSetze (daño creciente)")
	setze_damage *= 2

func _apply_time_card_effect(card: Resource, slot_index: int) -> void:
	print("Efecto periódico de: ", card.name)
	# Asumiendo que cada carta tiene un campo 'idName' (ej. "idCatorze")
	var func_name = card.idName
	if CardEffects.has_method(func_name):
		# Llamar a la función pasando el enemigo (y quizá otros parámetros)
		CardEffects.call(func_name, enemy)
		# Actualizar UI (por si la función modificó vidas)
		EnemyHp.text = str(max(0, enemy.hp))
		Hp.text = str(max(0, CharacterStats.hp))
	else:
		print("ERROR: No existe función ", func_name, " para la carta ", card.name)

# ============================================================
# FUNCIONES CENTRALES PARA DAÑO, CURACIÓN Y EFECTOS PASIVOS
# ============================================================

# Aplica daño al enemigo teniendo en cuenta modificadores (idDotze, idDiset)
func apply_damage_to_enemy(base_damage: float, source: String = "desconocido") -> void:
	var total_damage = base_damage
	
	# idDotze (12): cada vez que haces daño, +1 adicional
	if _is_card_equipped_by_id("idDotze"):
		total_damage += 1
	
	# idDiset (99): 1% de probabilidad de crítico (9999 daño)
	if _is_card_equipped_by_id("idDiset"):
		if randf() <= 0.01:
			total_damage = 9999
			print("¡CRÍTICO! 9999 de daño")
	
	enemy.hp -= total_damage
	if enemy.hp < 0:
		enemy.hp = 0
	EnemyHp.text = str(enemy.hp)
	print(source, " inflige ", total_damage, " de daño. Vida enemigo: ", enemy.hp)

# Aplica curación al jugador y dispara idNou si procede
func apply_heal_to_player(heal_amount: float, source: String = "desconocido") -> void:
	var old_hp = CharacterStats.hp
	CharacterStats.hp = min(CharacterStats.maxHp, CharacterStats.hp + heal_amount)
	var healed = CharacterStats.hp - old_hp
	Hp.text = str(CharacterStats.hp)
	print(source, " cura ", healed, " HP")
	
	# idNou (9): al curarte, haces 50% de la vida curada en daño al enemigo
	if healed > 0 and _is_card_equipped_by_id("idNou"):
		var damage = floor(healed * 0.5)
		if damage > 0:
			apply_damage_to_enemy(damage, "idNou (efecto de cura)")

# Función llamada cuando el jugador recibe daño (para efectos pasivos)
func on_player_takes_damage(damage_amount: float) -> void:
	# idDeu (10): al recibir daño, haces 5 de daño al enemigo
	if _is_card_equipped_by_id("idDeu"):
		apply_damage_to_enemy(5, "idDeu (contraataque)")
	
	# idOnze (11): al recibir daño, te curas 1 de vida
	if _is_card_equipped_by_id("idOnze"):
		apply_heal_to_player(1, "idOnze (cura al recibir daño)")
	
	# idTretze (13): 10% de probabilidad de devolver el daño recibido
	if _is_card_equipped_by_id("idTretze"):
		if randf() <= 0.1:
			apply_damage_to_enemy(damage_amount, "idTretze (devolver daño)")
	
	# idQuinze (15): cuando la vida baja del 30% (una sola vez)
	if not quinze_used and _is_card_equipped_by_id("idQuinze"):
		var threshold = CharacterStats.maxHp * 0.3
		if CharacterStats.hp <= threshold:
			quinze_used = true
			var damage = floor(enemy.hp * 0.15)
			if damage > 0:
				apply_damage_to_enemy(damage, "idQuinze (15% vida enemigo)")

# Comprueba si una carta con un id específico está equipada en algún slot
func _is_card_equipped_by_id(card_id: String) -> bool:
	for card in CharacterStats.slots:
		if card and card.idName == card_id:
			return true
	return false

# ============================================================
# SEÑALES Y EVENTOS DEL JUEGO
# ============================================================

func _on_button_up_next_stage() -> void:
	GameManager.nextStage()

func _on_basic_attack_timer_timeout() -> void:
	# Daño básico del enemigo al jugador
	var damage = enemy.passiveDmg
	CharacterStats.hp -= damage
	if CharacterStats.hp < 0:
		CharacterStats.hp = 0
	Hp.text = str(CharacterStats.hp)
	print("El enemigo ataca por ", damage, " de daño")
	# Disparar efectos pasivos por recibir daño
	on_player_takes_damage(damage)
