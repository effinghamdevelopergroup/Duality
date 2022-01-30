extends KinematicBody

export var jump = -350
export var speed = 100
export var gravity = 70
var target
var space_state
var velocity = Vector3.ZERO
onready var animation = $IceGollem/AnimationPlayer
var active_ability = AbilityDatabase.IceLance


func _ready():
	space_state = get_world().direct_space_state


func _physics_process(delta):
	apply_gravity(delta)
	animation.play("Idle")
	if target:
		var result = space_state.intersect_ray($Area/CollisionPolygon.global_transform.origin, target.global_transform.origin)
		if result:
			if result.collider.is_in_group("Player"):
				look_at(target.global_transform.origin, Vector3.UP)
				#animation.playback_speed = 8
				#animation.play("Move")
				move_to_target(delta)
			else:
				animation.play("Idle")


func apply_gravity(delta):
	velocity.y -= gravity * delta


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		print("HI")
		target = body


func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		print("bye")
		target = null


func move_to_target(delta):
	var direction = (target.transform.origin - transform.origin).normalized()
	move_and_slide(direction * speed * delta, Vector3.UP)
