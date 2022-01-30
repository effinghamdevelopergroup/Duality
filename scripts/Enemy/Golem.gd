extends KinematicBody

export var jump = -350
export var speed = 100
export var gravity = 70
var health = 100
var target
var space_state
var velocity = Vector3.ZERO
onready var animation = $IceGollem/AnimationPlayer
onready var gollem_ability_timer = get_node("GollemAbilityTimer")
var active_ability = AbilityDatabase.IceLance
signal use_ability


func _ready():
	space_state = get_world().direct_space_state
	gollem_ability_timer.set_one_shot(false)


func dead():
	return (health <= 0)


func _physics_process(delta):
	if dead():
		queue_free()
	apply_gravity(delta)
	animation.play("Move")
	if target:
		var result = space_state.intersect_ray($Area/CollisionPolygon.global_transform.origin, target.global_transform.origin)
		if result:
			if result.collider.is_in_group("Player"):
				look_at(target.global_transform.origin, Vector3.UP)
				move_to_target(delta)
			else:
				animation.play("Idle")
		create_ability()
		restart_ability_timer()


func apply_gravity(delta):
	velocity.y -= gravity * delta


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		target = body


func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		target = null


func move_to_target(delta):
	var direction = (target.transform.origin - transform.origin).normalized()
	move_and_slide(direction * speed * delta, Vector3.UP)


func create_ability():
	if gollem_ability_timer.is_stopped():
		emit_signal('use_ability', 
					active_ability, 
					$IceGollem.get_global_transform(),
					$IceGollem.get_global_transform())


func restart_ability_timer():
	gollem_ability_timer.set_wait_time(.01)
	gollem_ability_timer.start()


func _on_GollemAbilityTimer_timeout():
	gollem_ability_timer.stop()


func _on_Area2_area_entered(area):
	if area.name == "IceBlast" and active_ability != AbilityDatabase.IceLance:
		health -= 10
		area.queue_free()
	elif area.name == "Fireball" and active_ability != AbilityDatabase.Fireball:
		health -= 10
		area.queue_free()

