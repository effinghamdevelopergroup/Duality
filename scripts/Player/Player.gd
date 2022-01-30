class_name Player
extends KinematicBody

export var max_speed = 12
export var gravity = 70
export var jump_impulse = 25

#Player Abilities
var known_abilities = { }

var active_ability

var dead = false
var can_move = true
var velocity = Vector3.ZERO
onready var pivot = $PlayerModel
onready var animation = $PlayerModel/AnimationPlayer
onready var health = $Health
onready var player_ability_timer = get_node("PlayerAbilityTimer")
onready var game_over_screen = get_node("InterfaceLayer/GameOverScreen/Panel")
signal use_ability

func _ready():
	AbilityDatabase.Plyr = self
	set_process(true)
	player_ability_timer.set_one_shot(false)


func isMoving():
	return (velocity.length() > 1.5)


func die():
	game_over_screen.show()


func dead():
	return (health.health <= 0)


func _physics_process(delta):
	# Yes I know this doesn't feel right but here we are
	if dead():
		die()
		return
	var input_vector = get_input_vector()
	apply_movement(input_vector)
	apply_animations(input_vector)
	apply_gravity(delta)
	#jump()

	velocity = move_and_slide(velocity, Vector3.UP)
	var lookDir = velocity
	lookDir.y = 0
	if input_vector != Vector3.ZERO and isMoving() == true:
		pivot.look_at(lookDir*-20, Vector3.UP)

func _process(delta):
	# Yes I know this doesn't feel right but here we are
	if dead():
		die()
		return
	footsteps_loop()
	switch_ability()
	use_ability()

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
		#pivot.look_at(velocity*-20, Vector3.UP)
		animation.playback_speed = 8
		animation.play("Move")


func apply_gravity(delta):
	if !is_on_floor():
		velocity.y -= gravity * delta

func jump():
	if is_on_floor() and Input.is_action_pressed("Jump"):
		velocity.y = jump_impulse
		
func footsteps_loop():
	if $Timer.time_left <= 0 and isMoving() == true:
		$AudioStreamPlayer.pitch_scale = rand_range(0.8, 1.2)
		$AudioStreamPlayer.play()
		$Timer.start(0.2)

func learn_ability(choosen_ability):
	var ability_to_learn = AbilityDatabase.Fireball.instance()
	#TODO: Add choosen ability to the players collection.

func switch_ability():
	#Temp code to switch abilities for testing.
	if Input.is_action_pressed("SwitchAbility") and known_abilities.size() < 0:
		if active_ability == known_abilities["Fireball"]:
			active_ability = known_abilities["IceLance"]
		else:
			active_ability = known_abilities["Fireball"]
		print(active_ability)

func use_ability():
	if Input.is_action_pressed("Ability") and player_ability_timer.is_stopped():
		create_ability()
		restart_ability_timer()

func create_ability():
	#var ability = active_ability.instance()#IceLance.instance()
	#owner.add_child(ability)
	#ability.transform = $Head.global_transform
	#ability.velocity = ability.transform.basis.z * ability.ability_velocity
	if active_ability != null:
		emit_signal('use_ability', 
					active_ability, 
					$PlayerModel.get_global_transform(),
					$Hands.get_global_transform())

func restart_ability_timer():
	player_ability_timer.set_wait_time(.5)
	player_ability_timer.start()

func _on_PlayerAbilityTimer_timeout():
	player_ability_timer.stop()
	pass # Replace with function body.


func _on_Timer_timeout():
	pass # Replace with function body.

func _on_ability_learned():
	print("I'm in the player script now bitches")
	pass
