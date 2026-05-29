extends Node


var selectedCharacter = {}

var currentWindow=0
var currentStage=1
var stages={}
var stageTypes=['battle','randomEvent']

var functionsInInventory = {}

func setCharacter(data):
	selectedCharacter= data

func nextStage():
	if currentWindow == 30:
		get_tree().change_scene_to_file("res://scenes/score.tscn")
	
	else:
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
