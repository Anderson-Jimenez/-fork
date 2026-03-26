extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func obtainRandomFunction():
	var characterCondicions=[]
	for i in range(4):
		var rand = randi_range(1,4)
		var nomObj="obj"+str(rand)
		characterCondicions.append(nomObj)
	
	return characterCondicions

func obj1():
	return "obj1"

func obj2():
	return "obj2"

func obj3():
	return "obj3"

func obj4():
	return "obj4"
