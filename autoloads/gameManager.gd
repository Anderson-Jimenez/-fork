extends Node


var selectedCharacter = {}

var currentStage=0
var stages={}
var stageTypes=['battle','shop','randomEvent']

var functionsInInventory = {}

func setCharacter(data):
	selectedCharacter= data

func routeGenerator():
	for i in range(11):
		var rand = stageTypes.pick_random()
		stages[i]=rand
	
	stages[0]='home'
	stages[10]='boss'
