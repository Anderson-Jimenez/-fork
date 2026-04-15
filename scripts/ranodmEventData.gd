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
