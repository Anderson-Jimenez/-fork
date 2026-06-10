extends Node

func idU():
	if CharacterStats.cardActivated == 1:
		return 4

func idDos():
	if CharacterStats.dmgDealed == 1:
		return 2

func idTres():
	if CharacterStats.dmgRecived == 1:
		return 2

func idQuat():
	if CharacterStats.dmgRecived == 1:
		return 5

func idCinc():
	var counterChance=0.25
	if randf() <= 0.25:
		print("mal torna!!")

func idSis():
	if CharacterStats.hp <= 15:
		print("poca vida +5 de mal")

func idSet(enemy):
	enemy.hp -= 10
	print("idSet: 10 de daño")
	
func idVuit(enemy):
	CharacterStats.hp = min(CharacterStats.maxHp, CharacterStats.hp + 15)
	print("idVuit: cura 15 HP")
		
func idNou(enemy, cantidad_curada):
	var daño = int(cantidad_curada * 0.5)
	enemy.hp -= daño
	print("idNou: causa ", daño, " de daño al curarse")
		
func idDeu(enemy, _damage_recibido):
	enemy.hp -= 5
	print("idDeu: contraataca con 5 de daño")
	
func idOnze(_enemy, _damage_recibido):
	CharacterStats.hp = min(CharacterStats.maxHp, CharacterStats.hp + 1)
	print("idOnze: cura 1 HP")
		
func idDotze(_enemy, _damage_infligido):
	# Se suma +1 al daño que se va a aplicar. Mejor implementarlo en el script principal.
	pass

func idTretze(enemy, damage_recibido):
	if randf() <= 0.1:
		enemy.hp -= damage_recibido
		print("idTretze: devuelve ", damage_recibido, " de daño")
		
func idCatorze(enemy):
	var damage = randi_range(1, 10)
	enemy.hp -= damage
	print("Causaste ", damage, " de daño aleatorio")
		
var quinze_usado = false
func idQuinze(enemy):
	if not quinze_usado and CharacterStats.hp <= CharacterStats.maxHp * 0.3:
		quinze_usado = true
		var daño = int(enemy.hp * 0.15)
		enemy.hp -= daño
		print("idQuinze: inflige ", daño, " de daño (15% de la vida del enemigo)")

var dano_actual_setze = 0.5
func idSetze(enemy):
	enemy.hp -= dano_actual_setze
	print("idSetze: inflige ", dano_actual_setze, " de daño")
	dano_actual_setze *= 2
	
func idDiset(enemy):
	if randf() <= 0.01:
		enemy.hp -= 9999
		print("idDiset: ¡CRÍTICO! 9999 de daño")
		return true  # indica que hubo crítico
	return false

func idDivuit(enemy):
	enemy.hp = 0
	print("idDivuit: Enemigo eliminado.")
		
func idDinou(enemy):
	var option = randi_range(1, 3)
	match option:
		1:
			var dmg = 10
			enemy.hp -= dmg
			print("idDinou: 10 de daño al enemigo")
		2:
			var heal = 10
			CharacterStats.hp = min(CharacterStats.maxHp, CharacterStats.hp + heal)
			print("idDinou: curar 10 HP")
		3:
			var steal = 10
			enemy.hp -= steal
			CharacterStats.hp = min(CharacterStats.maxHp, CharacterStats.hp + steal)
			print("idDinou: robar 10 de vida (daño y cura)")
