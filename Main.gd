extends Node

func _on_use_ability(ability, _caster_transform, _hands):
	var ablty = ability.instance()
	#Update the spawn point for the insstanced ability to spawn infront of player.
	ablty.transform.origin = _hands.origin
	add_child(ablty)
	ablty.start(_caster_transform)
