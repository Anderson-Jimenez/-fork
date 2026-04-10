extends Node

#https://www.youtube.com/watch?v=STyN8fVI1Ew Video que explica cosas d'inventari, el canal te dos videos o tres en el qual explica
@onready var CurrentStage = $ColorRect/Stage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrentStage.text=str(GameManager.currentStage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
