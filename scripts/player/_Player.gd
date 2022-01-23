extends KinematicBody

onready var head = $Head
onready var camera = $Camera

var max_speed = 400
var speed = 0
var acceleration = 1200
var move_direction
var moving = false
var destination = Vector3()
var movement = Vector3()

func _input(event):
	pass

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if Input.is_action_just_pressed("Forward"):
			print("Moving Forward")
		if Input.is_action_just_pressed("Backward"):
			print("Moving Backward")
		if Input.is_action_just_pressed("Left"):
			print("Moving Left")
		if Input.is_action_just_pressed("Right"):
			print("Moving Right")

func _process(delta):
	AnimationLoop()

func _physics_process(delta):
	MovementLoop(delta)
	
func MovementLoop(delta):
	pass
	
func AnimationLoop():
	pass
