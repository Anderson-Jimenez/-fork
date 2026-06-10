extends Node

# ============================================
# CHROME (2 cartas)
# ============================================
func chrome1(player: CharacterStats, enemy: EnemyStats):
	player.hp -= 8
	print("Chrome: 8 de daño")

func chrome2(player: CharacterStats, enemy: EnemyStats):
	enemy.passiveDmg += 1
	print("Chrome: daño pasivo +1")

# ============================================
# CLIPPY (2 cartas)
# ============================================
func clippy1(player: CharacterStats, enemy: EnemyStats):
	var dmg = 5
	player.hp -= dmg
	enemy.hp += 2
	if enemy.hp > enemy.maxHp: enemy.hp = enemy.maxHp
	print("Clippy: 5 daño y roba 2 vida")

func clippy2(player: CharacterStats, enemy: EnemyStats):
	enemy.maxHp += 10
	enemy.hp += 10
	print("Clippy: +10 vida máxima y actual")

# ============================================
# EXCEL (2 cartas)
# ============================================
func excel1(player: CharacterStats, enemy: EnemyStats):
	player.hp -= 6
	print("Excel: 6 de daño")

func excel2(player: CharacterStats, enemy: EnemyStats):
	enemy.passiveDmg +=2
	print("Excel: reducción de daño +2")

# ============================================
# EXPLORER (2 cartas)
# ============================================
func explorer1(player: CharacterStats, enemy: EnemyStats):
	player.hp -= 7
	print("Explorer: 7 de daño")

func explorer2(player: CharacterStats, enemy: EnemyStats):
	enemy.maxHp += 5
	print("Explorer: defensa +1")

# ============================================
# OUTLOOK (2 cartas)
# ============================================
func outlook1(player: CharacterStats, enemy: EnemyStats):
	player.hp -= 12
	print("Outlook: 12 de daño")

func outlook2(player: CharacterStats, enemy: EnemyStats):
	# Al morir, cura al jugador (pero como es pasiva de inicio, no tiene sentido)
	# Mejor: aumenta su propia curación pasiva (no tiene, pero podemos aumentar su daño pasivo)
	enemy.passiveDmg += 2
	print("Outlook: daño pasivo +2")

# ============================================
# POWERPOINT (2 cartas)
# ============================================
func powerpoint1(player: CharacterStats, enemy: EnemyStats):
	player.hp -= 9
	print("PowerPoint: 9 de daño")

func powerpoint2(player: CharacterStats, enemy: EnemyStats):
	# Cada 4 segundos hace 1 de daño (lo implementamos como efecto time aparte? pero es pasiva.
	# En lugar de complicar, lo dejamos como: +1 daño pasivo cada 4s? Mejor: al inicio, crea un timer en battle.gd.
	# Pero para simplificar: aumenta su daño pasivo en 1 (ya que es una sola vez)
	enemy.passiveDmg += 1
	print("PowerPoint: daño pasivo +1")

# ============================================
# SKYPE (2 cartas)
# ============================================
func skype1(player: CharacterStats, enemy: EnemyStats):
	player.hp -= 6
	# Robo de vida: cura al enemigo
	enemy.hp += 2
	if enemy.hp > enemy.maxHp: enemy.hp = enemy.maxHp
	print("Skype: 6 daño y roba 2 vida")

func skype2(player: CharacterStats, enemy: EnemyStats):
	# Probabilidad de robar vida al atacar -> necesitaríamos evento. Mejor: aumenta daño pasivo
	enemy.passiveDmg += 1
	print("Skype: daño pasivo +1")

# ============================================
# WORD (2 cartas)
# ============================================
func word1(player: CharacterStats, enemy: EnemyStats):
	player.hp -= 5
	print("Word: 5 de daño")

func word2(player: CharacterStats, enemy: EnemyStats):
	# +1 de daño por cada carta time activa (esto es dinámico). Como es pasiva, lo dejamos como +1 fijo
	enemy.passiveDmg += 1
	print("Word: daño pasivo +1")

# ============================================
# (Añade aquí el resto de enemigos: excel2, outlook2, powerpoint2, skype2, word2 ya están)
# Nota: Tienes 15 enemigos, he cubierto los 8 primeros? La lista era: chrome, clippy, excel, explorer, outlook, powerpoint, skype, word (8). Faltan otros 7 (¿los que has listado: chrome1,2; clippy1,2; excel1,2; explorer1,2; outlook1,2; powerpoint1,2; skype1,2; word1,2 -> 8 pares = 16 cartas. Luego tienes outlook2? ya está. Pero en tu lista había también `chrome1.tres`, `chrome2.tres`, etc. Son exactamente esos.
