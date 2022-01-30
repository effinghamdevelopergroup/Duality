class_name IceLance
extends Area

signal exploded

export var ability_velocity = 25
export var g = Vector3.DOWN * 5
var velocity = Vector3.ZERO
var caster_transform

func _ready():
	pass

func _physics_process(delta):
	pass

func start(_caster_transform):
	caster_transform = _caster_transform

func _process(delta):
	translate(caster_transform.basis.z * ability_velocity * delta)

func _on_VisibilityNotifier_screen_exited():
	queue_free()

func _on_IceBlast_area_entered(area):
	emit_signal("exploded", transform.origin)
	#queue_free()
