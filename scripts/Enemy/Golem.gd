extends KinematicBody

export var speed = 100
var target
var space_state



func _ready():
	space_state = get_world().direct_space_state


func _physics_process(delta):
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		print(result)
		if result.collider.is_in_group("Player"):
			look_at(target.global_transform.origin, Vector3.UP)
			move_to_target(delta)


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		target = body


func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		target = null


func move_to_target(delta):
	var direction = (target.transform.origin - transform.origin).normalized()
	print("HI")
	move_and_slide(direction * speed * delta, Vector3.UP)
