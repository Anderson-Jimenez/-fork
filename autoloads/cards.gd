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

func idSet():
	if CharacterStats.hp <= 15:
		print("Ola")
