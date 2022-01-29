extends Node

func _on_use_ability(ability, _caster_transform):
	var ablty = ability.instance()
	ablty.transform.origin = _caster_transform.origin
	add_child(ablty)
	ablty.start(_caster_transform)
