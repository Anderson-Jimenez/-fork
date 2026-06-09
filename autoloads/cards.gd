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
	CharacterStats.dmgDealed += 10
	
func idVuit():
	if CharacterStats.hp <= 15:
		print("Ola")
		
func idNou():
	if CharacterStats.hp <= 15:
		print("Ola")
		
func idDeu():
	if CharacterStats.hp <= 15:
		print("Ola")

func idOnze():
	if CharacterStats.hp <= 15:
		print("Ola")
		
func idDotze():
	if CharacterStats.hp <= 15:
		print("Ola")

func idTretze():
	if CharacterStats.hp <= 15:
		print("Ola")
		
func idCatorze():
	if CharacterStats.hp <= 15:
		print("Ola")
		
func idQuinze():
	if CharacterStats.hp <= 15:
		print("Ola")
func idSetze():
	if CharacterStats.hp <= 15:
		print("Ola")

func idDivuit():
	if CharacterStats.hp <= 15:
		print("Ola")
		
func idDinou():
	if CharacterStats.hp <= 15:
		print("Ola")
