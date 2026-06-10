extends Control

@onready var CurrentWindow = $ColorRect/Stage

@onready var EnemySprite = $ColorRect/BossArea/bossSprite
@onready var EnemyHp = $ColorRect/BossArea/HBoxContainer/bossHp
@onready var EnemyMaxHp = $ColorRect/BossArea/HBoxContainer/bossMaxHp
@onready var EnemyName = $ColorRect/BossArea/bossName

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

@onready var enemyCard1 = $ColorRect/BossArea/bossCardArea/card1
@onready var enemyCard1L = $ColorRect/BossArea/bossCardArea/card1/Label
@onready var enemyCard2 = $ColorRect/BossArea/bossCardArea/card2
@onready var enemyCard2L = $ColorRect/BossArea/bossCardArea/card2/Label

@onready var timer = $BattleTimer
@onready var TimerLabel = $ColorRect/Time
@onready var basicTime = $BasicAttackTimer
@onready var BasicAttackProgress = $ColorRect/BossArea/BasicAttackProgress
@onready var logsActions = $ColorRect/logs/Accions

var card_scene = preload("res://scenes/cardScene.tscn")
var enemies: Array[EnemyData] = []

var slot_cooldowns = []
var setze_timer: Timer
var setze_damage: float = 0.5
var quinze_used: bool = false
var enemy_cooldowns = []
var enemy_defeated: bool = false

func _ready() -> void:
	CurrentWindow.text = str(GameManager.currentWindow)
	load_enemies()
	var enemy_data = get_random_enemy()
	EnemyStats.setEnemy(enemy_data)
	
	EnemySprite.texture = EnemyStats.sprite
	EnemyHp.text = str(EnemyStats.hp)
	EnemyMaxHp.text = str(EnemyStats.maxHp)
	EnemyName.text = EnemyStats.name
	
	slot1L.text = CharacterStats.slots[0].name if CharacterStats.slots[0] else "No Card"
	slot2L.text = CharacterStats.slots[1].name if CharacterStats.slots[1] else "No Card"
	slot3L.text = CharacterStats.slots[2].name if CharacterStats.slots[2] else "No Card"
	slot4L.text = CharacterStats.slots[3].name if CharacterStats.slots[3] else "No Card"
	
	_card_type_time()
	_setup_special_timers()
	_setup_enemy_cards()
	
	Sprite.texture = load(CharacterStats.sprite)
	Hp.text = str(CharacterStats.hp)
	MaxHp.text = str(CharacterStats.maxHp)
	CharacterName.text = CharacterStats.nameChar
	
	# Configurar el RichTextLabel para scroll automático
	logsActions.scroll_following = true
	
	# Animación de entrada del log (opcional)
	var tween = create_tween()
	tween.tween_property(logsActions, "visible_ratio", 1.0, 1.5)

func add_log(message: String, type: String = "info") -> void:
	var color = "#ffffff"
	match type:
		"damage": color = "#ff8888"
		"heal": color = "#88ff88"
		"crit": color = "#ffff88"
		"player": color = "#88ccff"
		"enemy": color = "#ffaa66"
		"error": color = "#ff6666"
		_: color = "#cccccc"
	
	var colored_message = "[color=" + color + "]" + message + "[/color]"
	logsActions.append_text(colored_message + "\n")
	logsActions.scroll_to_line(logsActions.get_line_count() - 1)

func load_enemies() -> void:
	var path = "res://resources/enemies/stage" + str(GameManager.currentStage) + "/bosses/"
	var dir = DirAccess.open(path)
	if not dir:
		return
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if file_name.ends_with(".tres"):
			enemies.append(load(path + file_name))
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
	if remainingTime <= 0:
		get_tree().change_scene_to_file("res://scenes/gameOver.tscn")
		return
	
	BasicAttackProgress.value = basicTime.time_left
	
	for cd in slot_cooldowns:
		if cd.active:
			cd.remaining -= delta
			cd.bar.value = cd.remaining
			if cd.remaining <= 0:
				_apply_time_card_effect(cd.card, cd.slot_index)
				cd.remaining = cd.total
	
	for ec in enemy_cooldowns:
		ec.remaining -= delta
		ec.bar.value = ec.remaining
		if ec.remaining <= 0:
			var func_name = ec.card.idName
			if EnemyCardEffects.has_method(func_name):
				add_log("Carta enemiga '" + ec.card.name + "' -> " + func_name, "enemy")
				EnemyCardEffects.call(func_name, CharacterStats, EnemyStats)
				Hp.text = str(CharacterStats.hp)
				EnemyHp.text = str(EnemyStats.hp)
			else:
				add_log("ERROR: No existe función " + func_name, "error")
			ec.remaining = ec.total

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
			bar.visible = true
			bar.max_value = card.cooldown
			bar.value = card.cooldown
			slot_cooldowns.append({
				"bar": bar,
				"remaining": card.cooldown,
				"total": card.cooldown,
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
	if _is_card_equipped_by_id("idSetze"):
		setze_timer = Timer.new()
		setze_timer.wait_time = 3.0
		setze_timer.timeout.connect(_apply_setze_effect)
		add_child(setze_timer)
		setze_timer.start()
		_apply_setze_effect()

func _apply_setze_effect() -> void:
	if setze_damage <= 0:
		return
	add_log("idSetze: " + str(setze_damage) + " de daño creciente", "damage")
	apply_damage_to_enemy(setze_damage, "idSetze")
	setze_damage *= 2

func _setup_enemy_cards() -> void:
	var containers = [enemyCard1, enemyCard2]
	var labels = [enemyCard1L, enemyCard2L]
	var card_index = 0
	
	for card in EnemyStats.cards:
		if card_index >= containers.size():
			break
		
		# Mostrar nombre
		labels[card_index].text = card.name if card.name else "?"
		
		if card.type == "time":
			var bar = ProgressBar.new()
			bar.name = "CooldownBar_" + str(card_index)
			bar.size = Vector2(80, 12)
			bar.position = Vector2(20, 120)
			bar.visible = true
			bar.show_percentage = false
			bar.max_value = card.cooldown
			bar.value = card.cooldown
			containers[card_index].add_child(bar)
			enemy_cooldowns.append({
				"card": card,
				"bar": bar,
				"remaining": card.cooldown,
				"total": card.cooldown
			})
		else:
			var func_name = card.idName
			if EnemyCardEffects.has_method(func_name):
				add_log("Carta pasiva enemiga: " + card.name, "enemy")
				EnemyCardEffects.call(func_name, CharacterStats, EnemyStats)
				Hp.text = str(CharacterStats.hp)
				EnemyHp.text = str(EnemyStats.hp)
			else:
				add_log("ERROR: No existe función pasiva " + func_name, "error")
		
		card_index += 1
	
	# Opcional: si hay menos cartas que contenedores, limpiar textos sobrantes
	for i in range(card_index, containers.size()):
		labels[i].text = "No Card"

func _apply_time_card_effect(card: Resource, slot_index: int) -> void:
	var func_name = card.idName
	if CardEffects.has_method(func_name):
		add_log("Carta '" + card.name + "' activa: " + func_name, "player")
		CardEffects.call(func_name, EnemyStats)
		EnemyHp.text = str(max(0, EnemyStats.hp))
		Hp.text = str(max(0, CharacterStats.hp))
	else:
		add_log("ERROR: No existe función " + func_name, "error")

func apply_damage_to_enemy(base_damage: float, source: String = "desconocido") -> void:
	if enemy_defeated:
		return
	var total_damage = base_damage
	if _is_card_equipped_by_id("idDotze"):
		total_damage += 1
	if _is_card_equipped_by_id("idDiset") and randf() <= 0.01:
		total_damage = 9999
		add_log("¡CRÍTICO! 9999 de daño", "crit")
	
	EnemyStats.hp -= total_damage
	if EnemyStats.hp < 0:
		EnemyStats.hp = 0
	EnemyHp.text = str(EnemyStats.hp)
	add_log(source + " inflige " + str(total_damage) + " de daño. Vida enemigo: " + str(EnemyStats.hp), "damage")
	
	if EnemyStats.hp <= 0 and not enemy_defeated:
		enemy_defeated = true
		_on_enemy_defeated()

func apply_heal_to_player(heal_amount: float, source: String = "desconocido") -> void:
	var old_hp = CharacterStats.hp
	CharacterStats.hp = min(CharacterStats.maxHp, CharacterStats.hp + heal_amount)
	var healed = CharacterStats.hp - old_hp
	Hp.text = str(CharacterStats.hp)
	add_log(source + " cura " + str(healed) + " HP", "heal")
	
	if healed > 0 and _is_card_equipped_by_id("idNou"):
		var damage = floor(healed * 0.5)
		if damage > 0:
			apply_damage_to_enemy(damage, "idNou")

func on_player_takes_damage(damage_amount: float) -> void:
	if _is_card_equipped_by_id("idDeu"):
		add_log("idDeu: contraataca con 5 de daño", "player")
		apply_damage_to_enemy(5, "idDeu")
	if _is_card_equipped_by_id("idOnze"):
		add_log("idOnze: cura 1 HP al recibir daño", "heal")
		apply_heal_to_player(1, "idOnze")
	if _is_card_equipped_by_id("idTretze") and randf() <= 0.1:
		add_log("idTretze: devuelve " + str(damage_amount) + " de daño", "player")
		apply_damage_to_enemy(damage_amount, "idTretze")
	
	if not quinze_used and _is_card_equipped_by_id("idQuinze"):
		var threshold = CharacterStats.maxHp * 0.3
		if CharacterStats.hp <= threshold:
			quinze_used = true
			var damage = floor(EnemyStats.hp * 0.15)
			if damage > 0:
				add_log("idQuinze: inflige " + str(damage) + " (15% vida enemigo)", "damage")
				apply_damage_to_enemy(damage, "idQuinze")

func _is_card_equipped_by_id(card_id: String) -> bool:
	for card in CharacterStats.slots:
		if card and card.idName == card_id:
			return true
	return false

func _on_button_up_next_stage() -> void:
	GameManager.currentStage += 1
	GameManager.totalStages += 1
	GameManager.nextStage()

func _on_basic_attack_timer_timeout() -> void:
	if enemy_defeated:
		return
	var damage = EnemyStats.passiveDmg
	CharacterStats.hp -= damage
	if CharacterStats.hp < 0:
		CharacterStats.hp = 0
	Hp.text = str(CharacterStats.hp)
	add_log("El enemigo ataca por " + str(damage) + " de daño", "enemy")
	on_player_takes_damage(damage)

func _on_enemy_defeated() -> void:
	add_log("Enemigo derrotado. Pasando a siguiente etapa...", "info")
	timer.stop()
	basicTime.stop()
	if setze_timer:
		setze_timer.stop()
	for cd in slot_cooldowns:
		cd.active = false
	_on_button_up_next_stage()
