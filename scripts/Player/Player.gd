extends KinematicBody

export var max_speed = 12
export var gravity = 70
export var jump_impulse = 25

var velocity = Vector3.ZERO

onready var pivot = $PlayerModel
onready var animation = $PlayerModel/AnimationPlayer

#Spellcasting
var active_ability


func isMoving():
	return (velocity.length() > 1.5)


func _physics_process(delta):
	var input_vector = get_input_vector()
	apply_movement(input_vector)
	apply_animations(input_vector)
	apply_gravity(delta)
	footsteps_loop()
	#jump()
	use_ability()
	velocity = move_and_slide(velocity, Vector3.UP)


func get_input_vector():
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input_vector.z = Input.get_action_strength("Backward") - Input.get_action_strength("Forward")
	
	return input_vector.normalized()


func apply_movement(input_vector):
	velocity.x = input_vector.x * max_speed
	velocity.z = input_vector.z * max_speed


func apply_animations(input_vector):
	if input_vector == Vector3.ZERO:
		animation.play("Idle")
	if input_vector != Vector3.ZERO and isMoving() == true:
		pivot.look_at(velocity*-20, Vector3.UP)
		animation.playback_speed = 8
		animation.play("Move")


func apply_gravity(delta):
	velocity.y -= gravity * delta


func jump():
	if is_on_floor() and Input.is_action_pressed("Jump"):
		velocity.y = jump_impulse

func use_ability():
	if Input.is_action_pressed("Ability"):
		print("ABILITY USED!")
		pass


func footsteps_loop():
	if $Timer.time_left <= 0 and isMoving() == true:
		$AudioStreamPlayer.pitch_scale = rand_range(0.8, 1.2)
		$AudioStreamPlayer.play()
		$Timer.start(0.2)
