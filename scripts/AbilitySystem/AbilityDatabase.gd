extends Node

export (PackedScene) var Fireball = preload("res://scenes/Game/Abilities/Fireball.tscn")
export (PackedScene) var IceLance = preload("res://scenes/Game/Abilities/IceLance.tscn")

var Plyr setget SetPlayer

var Choice = "NotSet" setget SetAbility

signal ability_learned

func SetAbility(objPassed):
	Choice = objPassed
	if Choice == "Fireball":
		Plyr.known_abilities["Fireball"] = Fireball
		Plyr.active_ability = Plyr.known_abilities["Fireball"]
	else:
		Plyr.known_abilities["IceLance"] = IceLance
		Plyr.active_ability = Plyr.known_abilities["IceLance"]

func SetPlayer(objPassed):
	Plyr = objPassed
	print(objPassed.known_abilities)
