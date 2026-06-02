extends Panel

signal card_clicked(card_data) # para enviar una "señal" de q han clicado el componente

@onready var CardName = $CardName
@onready var CardType = $CardType
@onready var CardDesc = $CardDesc

var data = {}  # guardar datos en diccionario

func setup(card_data):
	data = card_data
	CardName.text = card_data["name"]
	CardType.text = card_data["description"]
	CardDesc.text = "res, hola"
	
func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		card_clicked.emit(data)  #manda la señal para usarla y q se pueda enseñar la info donde queremos.
