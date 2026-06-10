extends Control

@onready var list = $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(Db.obtenir_puntuacions(10))
	carregar_puntuacions()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func carregar_puntuacions():
	var scores = Db.obtenir_puntuacions(10)

	for i in scores.size():
		var score = scores[i]

		# Crea una fila HBox per cada puntuació
		var row = HBoxContainer.new()
		row.add_theme_constant_override("separation", 20)

		# Nom del jugador
		var label_nom = Label.new()
		label_nom.text = score["personatge"]
		label_nom.custom_minimum_size.x = 150
		# Puntuació
		var label_pts = Label.new()
		label_pts.text = "%d pts" % score["puntuacio"]
		
		var label_status = Label.new()
		if score["estatPartida"]==1:
			label_status.text = "Guanyada"
		else:
			label_status.text = "Perduda"

		var label_date = Label.new()
		label_date.text = score["data"]

		# Afegeix els labels a la fila
		row.add_child(label_nom)
		row.add_child(label_pts)
		row.add_child(label_status)
		row.add_child(label_date)

		# Afegeix la fila al VBox
		list.add_child(row)
