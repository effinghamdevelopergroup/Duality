class_name IceLance
extends Area

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal exploded

export var ability_velocity = 25
export var g = Vector3.DOWN * 5

var velocity = Vector3.ZERO
var caster_transform

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	pass
	#velocity += g * delta
	#look_at(transform.origin + velocity.normalized(), Vector3.UP)
	#transform.origin += velocity * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start(_caster_transform):
	caster_transform = _caster_transform

func _process(delta):
	translate(caster_transform.basis.z * ability_velocity * delta)

func _on_Area_body_entered(body):
	emit_signal("exploded", transform.origin)
	queue_free()

func _on_VisibilityNotifier_screen_exited():
	queue_free()
