class_name RandomEventData
extends Resource

@export var name: String
@export var context: String

@export var opcio1: String
@export var opcio1Value: String

@export var opcio2: String
@export var opcio2Value: String

@export var opcio3: String
@export var opcio3Value: String

#No crec que sigui lo millor, aqui van totes les funcions dels events

#Funcions General
func continuar():
	GameManager.nextStage()


#Positives
func curar():
	CharacterStats.hp=CharacterStats.hp+10
	
	if CharacterStats.hp > CharacterStats.maxHp:
		CharacterStats.hp = CharacterStats.maxHp
		
	print(CharacterStats.hp)
	GameManager.nextStage()

func moneyUp():
	CharacterStats.money=CharacterStats.money*2
	GameManager.nextStage()

# Negatives
func ferMal():
	CharacterStats.hp=CharacterStats.hp-5
	print(CharacterStats.hp)
	GameManager.nextStage()

func moneyDown():
	CharacterStats.money=CharacterStats.money/3
	GameManager.nextStage()
	
