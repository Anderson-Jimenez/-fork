extends Panel

@onready var CardName = $CardName
@onready var CardType = $CardType
@onready var CardDesc = $CardDesc

func setup(card_data):
	CardName.text = card_data["NAME"]
	CardType.text = card_data["TYPE"]
	CardDesc.text = card_data["DESC"]
