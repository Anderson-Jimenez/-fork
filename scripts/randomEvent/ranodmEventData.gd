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

func continuar():
	GameManager.nextStage
