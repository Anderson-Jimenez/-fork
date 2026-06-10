extends Node


var selectedCharacter = {}

var currentWindow=0
var totalWindows=0 

var currentStage=1 #D'aixo sols hi han 3, hi ha un lio de noms, stages en els altres llocs es del 1 al 30
var totalStages=1 #D'aixo sols hi han 3, hi ha un lio de noms, stages en els altres llocs es del 1 al 30

var stages={}
var stageTypes=['battle','randomEvent']

var functionsInInventory = {}

var inventoryScene = preload("res://scenes/inventary.tscn")
var inventoryInstance = null




func setCharacter(data):
	selectedCharacter= data

func nextStage():
	if currentWindow == 30:
		get_tree().change_scene_to_file("res://scenes/score.tscn")
	
	else:
		totalWindows+=1
		currentWindow+=1
		get_tree().change_scene_to_file("res://scenes/"+stages[currentWindow]+".tscn")


func routeGenerator():
	for i in range(31):
		var rand = stageTypes.pick_random()
		stages[i]=rand
	
	stages[0]='home'
	stages[5]='shop'
	stages[15]='shop'
	stages[25]='shop'
	stages[10]='bossBattle'
	stages[20]='bossBattle'
	stages[30]='bossBattle'


func emptyAllGameManager():
	stages={}
	currentWindow=0
	selectedCharacter = {}
	functionsInInventory = {}



func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		var blockedScenes = ["battle", "bossBattle"]
		if not blockedScenes.has(stages[currentWindow]):
			_toggle_inventory()

func _toggle_inventory():
	if inventoryInstance == null:
		inventoryInstance = inventoryScene.instantiate()
		get_tree().current_scene.add_child(inventoryInstance)
	else:
		inventoryInstance.queue_free()
		inventoryInstance = null
