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
@onready var timer = $BattleTimer
@onready var TimerLabel = $ColorRect/Time
@onready var basicTime = $BasicAttackTimer
@onready var BasicAttackProgress = $ColorRect/EnemyArea/BasicAttackProgress

var enemy: EnemyData
var enemies: Array[EnemyData] = []
var card_timers: Array = []


# ─── READY ───────────────────────────────────────────────────────────────────

func _ready() -> void:
	CurrentWindow.text = str(GameManager.currentWindow)

	load_enemies()
	enemy = get_random_enemy()

	EnemySprite.texture = enemy.sprite
	EnemyHp.text = str(enemy.hp)
	EnemyMaxHp.text = str(enemy.maxHp)
	EnemyName.text = enemy.name

	Sprite.texture = load(CharacterStats.sprite)
	Hp.text = str(CharacterStats.hp)
	MaxHp.text = str(CharacterStats.maxHp)
	CharacterName.text = CharacterStats.nameChar

	_spawn_battle_cards()


# ─── PROCESS ─────────────────────────────────────────────────────────────────

func _process(_delta: float) -> void:
	if CharacterStats.hp <= 0:
		get_tree().change_scene_to_file("res://scenes/gameOver.tscn")

	TimerLabel.text = str(round(timer.time_left))
	BasicAttackProgress.value = basicTime.time_left

	for entry in card_timers:
		entry["progress"].value = entry["timer"].wait_time - entry["timer"].time_left


# ─── HELPER: lee campo tanto de CardData como de Dictionary ──────────────────

func _get_card_value(card, key: String, default_val = ""):
	if card is CardData:
		if key == "name":        return card.name
		if key == "description": return card.description
		if key == "type":        return card.type
		if key == "cooldown":    return card.cooldown
		if key == "damage":      return card.damage
		if key == "heal":        return card.heal
		return default_val
	elif card is Dictionary:
		return card.get(key, default_val)
	return default_val


# ─── SPAWN DE CARTAS ─────────────────────────────────────────────────────────

func _spawn_battle_cards() -> void:
	for child in CardArea.get_children():
		child.queue_free()
	card_timers.clear()

	for card in CharacterStats.slots:
		if card == null:
			CardArea.add_child(_create_empty_slot())
		else:
			CardArea.add_child(_create_battle_card(card))


func _create_battle_card(card) -> Control:
	var card_type = str(_get_card_value(card, "type", ""))
	match card_type:
		"time":
			return _create_time_card(card)
		_:
			return _create_simple_card(card)


# ─── TIPOS DE PANEL ──────────────────────────────────────────────────────────

func _create_base_panel() -> PanelContainer:
	var panel = PanelContainer.new()
	panel.custom_minimum_size = Vector2(110, 140)
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.08, 0.08, 0.12)
	style.border_color = Color(0.8, 0.0, 1.0)
	style.set_border_width_all(2)
	style.set_corner_radius_all(4)
	panel.add_theme_stylebox_override("panel", style)
	return panel


func _create_simple_card(card) -> PanelContainer:
	var panel = _create_base_panel()

	var vbox = VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 6)
	panel.add_child(vbox)

	var name_lbl = Label.new()
	name_lbl.text = str(_get_card_value(card, "name", "???"))
	name_lbl.add_theme_font_size_override("font_size", 11)
	name_lbl.add_theme_color_override("font_color", Color.WHITE)
	name_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	name_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD
	vbox.add_child(name_lbl)

	var sep = HSeparator.new()
	vbox.add_child(sep)

	var desc_lbl = Label.new()
	desc_lbl.text = str(_get_card_value(card, "description", ""))
	desc_lbl.add_theme_font_size_override("font_size", 9)
	desc_lbl.add_theme_color_override("font_color", Color(0.75, 0.75, 0.75))
	desc_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD
	vbox.add_child(desc_lbl)

	return panel


func _create_time_card(card) -> PanelContainer:
	var panel = _create_simple_card(card)
	var cooldown = float(_get_card_value(card, "cooldown", 10.0))

	var bar = ProgressBar.new()
	bar.max_value = cooldown
	bar.value = 0.0
	bar.show_percentage = false
	bar.custom_minimum_size = Vector2(0, 12)

	var fill_style = StyleBoxFlat.new()
	fill_style.bg_color = Color(0.0, 1.0, 1.0)
	bar.add_theme_stylebox_override("fill", fill_style)

	# El vbox es el primer hijo del panel
	panel.get_child(0).add_child(bar)

	var t = Timer.new()
	t.wait_time = cooldown
	t.autostart = true
	panel.add_child(t)
	t.timeout.connect(_on_periodic_card_tick.bind(card, bar))

	card_timers.append({"timer": t, "progress": bar})

	return panel


func _create_empty_slot() -> PanelContainer:
	var panel = PanelContainer.new()
	panel.custom_minimum_size = Vector2(110, 140)
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.05, 0.05, 0.05)
	style.border_color = Color(0.2, 0.2, 0.2)
	style.set_border_width_all(1)
	style.set_corner_radius_all(4)
	panel.add_theme_stylebox_override("panel", style)

	var lbl = Label.new()
	lbl.text = "—"
	lbl.add_theme_color_override("font_color", Color(0.3, 0.3, 0.3))
	lbl.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	panel.add_child(lbl)

	return panel


# ─── EFECTOS DE CARTAS ───────────────────────────────────────────────────────

func _on_periodic_card_tick(card, bar: ProgressBar) -> void:
	_apply_card_effect(card)
	bar.value = 0.0


func _apply_card_effect(card) -> void:
	var dmg = int(_get_card_value(card, "damage", 0))
	var heal = int(_get_card_value(card, "heal", 0))

	if dmg > 0:
		enemy.hp -= dmg
		EnemyHp.text = str(enemy.hp)
		if enemy.hp <= 0:
			_on_enemy_defeated()

	if heal > 0:
		CharacterStats.hp = min(CharacterStats.hp + heal, CharacterStats.maxHp)
		Hp.text = str(CharacterStats.hp)


func _on_enemy_defeated() -> void:
	for entry in card_timers:
		entry["timer"].stop()
	basicTime.stop()
	timer.stop()
	print("Enemigo derrotado")
	# Aquí cambia de escena o muestra UI de victoria cuando lo tengas


# ─── ATAQUE BÁSICO ENEMIGO ───────────────────────────────────────────────────

func _on_basic_attack_timer_timeout() -> void:
	CharacterStats.hp -= enemy.passiveDmg
	Hp.text = str(CharacterStats.hp)


# ─── CARGA DE ENEMIGOS ───────────────────────────────────────────────────────

func load_enemies() -> void:
	var path = "res://resources/enemies/stage" + str(GameManager.currentStage) + "/basicEnemies/"
	var dir = DirAccess.open(path)
	if not dir:
		push_error("No se encontró el directorio de enemigos: " + path)
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


# ─── BOTONES ─────────────────────────────────────────────────────────────────

func _on_button_up_next_stage() -> void:
	GameManager.nextStage()
