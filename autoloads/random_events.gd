extends Node

#Funcions General
func continuar():
	GameManager.nextStage()

#Stage 1

func event_stg1_1(value):
	match value:
		1:
			GameManager.currentWindow = 29
			return "Entras al port i et transporta a un lloc inexplorat"
		2:
			return "Ignores el port i segueixes"

func event_stg1_2(value):
	var text=""
	match value:
		1:
			CharacterStats.money += -100
			return "Pagas per el office, -100€"
		2:
			return "Ignores el office i segueixes amb la teva vida"
		3:
			var probabilitat = randf()
			
			if probabilitat < 0.50:
				CharacterStats.money += 100
				text="Has conseguit hackejar l'office, +100€"
			else:
				CharacterStats.hp -= 20
				text="No has aconseguit hackejar l'office, -20 de vida"
			return text

func event_stg1_3(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()

			if probabilitat < 0.25:
				CharacterStats.hp += 10
				text="Has trobat informacio que podria ser util, +10 de vida"

			elif probabilitat < 0.50:
				CharacterStats.money += 100
				text="Has trobat criptomonedes, +100€"

			elif probabilitat < 0.75:
				CharacterStats.hp -= 10
				text="No has aconseguit hackejar l'office, -10 de vida"

			else:
				text="No trobes res en el correu"

			return text
		2:
			return "Decideixes no entrar en el correu"

func event_stg1_4(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()

			if probabilitat < 0.99:
				text="Et quedes mirant la presentació i aprecies el treball fet"
			else:
				CharacterStats.money+=400 
				text="Power Point et dona les gracies per a mirar la presentació i 400€"

			return text
		2:
			var probabilitat = randf()

			if probabilitat < 0.99:
				text="Borras el document i no passa res"
			else:
				CharacterStats.hp=0 
				text="Power Point s'enfada amb tu i et mata"

			return text

func event_stg1_5(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()
			if probabilitat < 0.50:
				CharacterStats.money=0
				text="Et roba totes les monedes"
			else:
				CharacterStats.maxHp+=15 
				text="En el document hi ha un sprite d'un kebab, +15 de vida maxima"

			return text
		2:
			var probabilitat = randf()
			
			if probabilitat < 0.25:
				CharacterStats.money=0
				text="Al borrar el document perds totes les monedes"
			else:
				CharacterStats.maxHp+=15 
				text="Al borrar el document recibeixes +100€"
			
			return text
		3:
			return "Ignoras el document"

func event_stg1_6(value):
	var text=""
	match value:
		1:
			return "Recibeixes una carta aleatoria"
		2:
			var probabilitat = randf()
			
			if probabilitat < 0.90:
				
				text="Borras el document i no passa res"
			else:
				CharacterStats.money+=-50
				text="Perds 50 monedes"
			
			return text
		3:
			return "Ignoras el document"
			
func event_stg1_7(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()
			
			if probabilitat < 0.50:
				CharacterStats.money+=200
				text="Consegueixes trobar criptomonedes, guanyes +200€"

			else:
				CharacterStats.hp=1
				text="El Windows Defender et veu i t'ataca, consegueixes escapar a 1 de vida"
			return text
		2:
			return "Decideixes anar-te abans de que et trobi el Windows Defender"

func event_stg1_8(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()
			
			if probabilitat < 0.50:
				CharacterStats.hp=CharacterStats.maxHp
				text="Et cures la vida al maxim"

			else:
				CharacterStats.hp=CharacterStats.hp/2
				text="Al menjar tel no sap molt be i perds la mitad de la vida"
				
			return text
		2:
			var probabilitat = randf()
			
			if probabilitat < 0.25:
				CharacterStats.money+=50
				text="El virus decideix donar-te 50€"

			elif probabilitat < 0.50:
				CharacterStats.maxHp+=15
				text="El virus decideix donar-te +15 de vida maxima"
			else:
				text="El virus decideix no ajudarte i t'ignora"
				
			return text
		3:
			return "Decideixes ignorar a l'altre virus"

#Stage 2

func event_stg2_1(value):
	match value:
		1:
			GameManager.currentWindow = 29
			return "Entras al port i et transporta a un lloc inexplorat"
		2:
			return "Ignores el port i segueixes"

func event_stg2_2(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()
			
			if probabilitat < 0.50:
				text="No trobes ninguna contrasenya"
			else:
				CharacterStats.maxHp += 25
				text="Trobes contrasenyes"

			return text
		2:
			return "Decideixes malgastar el teu temps en un altre part del ordinador"

func event_stg2_3(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()
			
			if probabilitat < 0.50:
				text="No trobes ninguna contrasenya"
			else:
				CharacterStats.money += 200
				text="Trobes contrasenyes, +200€"

			return text
		2:
			var probabilitat = randf()
			
			if probabilitat < 0.50:
				text="No trobes ninguna pestanya oberta"
			else:
				CharacterStats.hp += 30
				text="Et trobes amb la pestanya del correu oberta, +30 de vida"

			return text
		3:
			return "Decideixes malgastar el teu temps en un altre part del ordinador"

func event_stg2_4(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()

			if probabilitat < 0.25:
				CharacterStats.maxHp+=-10
				text="Perds 10 de vida maxima"

			elif probabilitat < 0.50:
				CharacterStats.maxHp+=10
				text="Guanyes 10 de vida maxima"

			elif probabilitat < 0.75:
				CharacterStats.money+=100
				text="Aconsegueixes +100€"

			else:
				CharacterStats.money+=-100 
				text="Perds -100€"

			return text
		2:
			return "Ignores la trucada"

func event_stg2_5(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()
			if probabilitat < 0.50:
				CharacterStats.hp=CharacterStats.hp/2
				text="El saludes, s'enfada amb tu i et treu la mitad de la vida"
			else: 
				text="El saludes pero no es dona ni compte que l'has saludat"

			return text

		2:
			return "T'amagas del Clippy"

func event_stg2_6(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()
			
			if probabilitat < 0.40:
				CharacterStats.money+=100
				text="Al activar-lo et dona +100€ i comença a fer el seu treball"
				
			elif probabilitat < 0.80:
				CharacterStats.maxHp+=25
				text="Al activar-lo et dona +25 de vida maxima i comença a fer el seu treball"
				
			else:
				CharacterStats.hp+=-20
				text="Al activar-lo algo surt malament i explota, recibeixes 20 de mal"
			
			return text
		2:
			return "No saps el que pot passar, així que decideixes deixar-lo on esta"
			
func event_stg2_7(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()
			
			if probabilitat < 0.50:
				CharacterStats.maxHp+=30
				text="Consegueixes trobar documents importants, aconsegueixes +30 de vida maxima"

			else:
				CharacterStats.hp=1
				text="El Windows Defender et veu i t'ataca, consegueixes escapar a 1 de vida"
			return text
		2:
			return "Decideixes anar-te abans de que et trobi el Windows Defender"

func event_stg2_8(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()
			
			if probabilitat < 0.50:
				text="Aconsegueixes fer que no exploti"

			else:
				CharacterStats.maxHp+=-10
				text="No aconsegueixes parar l'explosio i es peta, perds -10 de vida maxima"
				
			return text
		2:
			CharacterStats.hp+=-25
			return "Decideixes sortir corrents pero igualment recibeixes mal, -25 de vida"

#Stage 3

func event_stg3_1(value):
	match value:
		1:
			GameManager.currentWindow = 1
			GameManager.currentStage = 1
			
			return "Entras al port i et transporta a un lloc inexplorat"
		2:
			return "Ignores el port i segueixes"

func event_stg3_2(value):
	var text=""
	match value:
		1:
			CharacterStats.hp = CharacterStats.maxHp
			return "WinRar t'agraeix per comprar el winrar, et cura tota la vida"
		2:
			return "El winrar s'enva trist"

func event_stg3_3(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()
			
			if probabilitat < 0.25:
				CharacterStats.money+=100
				text="Trobes criptomonedes, +100€"
				
			elif probabilitat < 0.50:
				CharacterStats.hp+=30
				text="Trobes informació valuable, et cures 30 de vida"
				
			elif probabilitat < 0.75:
				CharacterStats.maxHp+=25
				text="Trobes una contrasenya, guanyes +25 de vida maxima"
				
			else:
				CharacterStats.hp +=-10
				CharacterStats.maxHp+=-5
				CharacterStats.money+=-50
				text="Et perds en el laberint de arxius, perds 10 de vida, 5 de vida maxima i 50€"

			return text
		2:
			CharacterStats.hp += -10
			return "Decideixes sortir del laberint, recibeixes 10 de mal"

func event_stg3_4(value):
	var text=""
	match value:
		1:
			CharacterStats.money+=-100

			var probabilitat = randf()

			if probabilitat < 0.50:
				CharacterStats.hp+=-20
				text="Perds 20 de vida"

			else:
				CharacterStats.maxHp+=-10
				text="Perds 10 de vida maxima"

			return text
		2:
			return "Decideixes no actualitzar-lo, +100€"

func event_stg3_5(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()
			if probabilitat < 0.20:
				CharacterStats.hp +=50
				CharacterStats.maxHp+=30
				CharacterStats.money+=200
				text="Consegueixes entrar amb sudo su, et cures 30 de vida, guanyes +30 de vida maxima i aconsegueixes +200€"
			else: 
				CharacterStats.hp +=-30
				text="No aconsegueixes entrar"

			return text

		2:
			return "Decideixes no fer arriesgat"

func event_stg3_6(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()
			
			if probabilitat < 0.20:
				text="El windows defender no et detecta"
			else:
				CharacterStats.hp+=-30
				text="El windows defender et detecta pero aconsegueixes escapar, perds -30 de vida"
			
			return text
		2:
			CharacterStats.money+=-150
			return "Et fas passar per un arxiu i no et detecta"
			
func event_stg3_7(value):
	var text=""
	match value:
		1:
			var probabilitat = randf()
			
			if probabilitat < 0.50:
				CharacterStats.hp=CharacterStats.maxHp
				text="Consegueixes trobar documents importants, et cures la vida al maxim"

			else:
				CharacterStats.hp=1
				text="El Windows Defender et veu i t'ataca, consegueixes escapar a 1 de vida"
			return text
		2:
			return "Decideixes anar-te abans de que et trobi el Windows Defender"

func event_stg3_8(value):
	var text=""
	match value:
		1:
			CharacterStats.money+=-200
			return "Decideixes comprar la informació"
		2:
			var probabilitat = randf()
			
			if probabilitat < 0.30:
				text="Aconsegueixes trobar la informació que necessitaves"
			else:
				CharacterStats.hp+=-25
				text="No aconsegueixes trobar la informació que necessitaves"

			return text
