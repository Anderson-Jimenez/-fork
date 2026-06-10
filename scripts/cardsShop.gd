extends Panel

signal card_clicked(card_data, preu) # para enviar una "señal" de q han clicado el componente
signal card_bought

@onready var CardName = $CardName
@onready var CardType = $CardType
@onready var CardDesc = $CardDesc
@onready var CardPrice = $CardPrice

var data = {}  # guardar datos en diccionario
var preu_actual = 0  # guarda el preu

func setup(card_data, preu: int):
	data = card_data
	preu_actual = preu
	CardName.text = card_data["name"]
	CardType.text = "ataque"
	CardDesc.text = card_data["description"]
	CardPrice.text = str(preu)

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		card_clicked.emit(data, preu_actual)  #manda la señal para usarla y q se pueda enseñar la info donde queremos.

func comprar():
	card_bought.emit()  # ← s'emet des de fora quan la compra és vàlida
	visible = false
