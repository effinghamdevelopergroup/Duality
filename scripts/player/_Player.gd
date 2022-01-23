extends KinematicBody

var gravity = -9.8
var velocity = Vector3()
var camera

const SPEED = 6
const ACCELERATION = 3
const DE_ACCELERATION = 5

func _ready():
	camera = get_node("Camera").get_global_transform()

func _input(event):
	pass

func _unhandled_input(event):
	pass

func _process(delta):
	AnimationLoop()

func _physics_process(delta):
	MovementLoop(delta)
	
func MovementLoop(delta):
	var direction = Vector3()

	if Input.is_action_pressed("Backward"):
		direction += camera.basis[2]
	if Input.is_action_pressed("Forward"):
		direction -= camera.basis[2]
	if Input.is_action_pressed("Right"):
		direction += camera.basis[0]
	if Input.is_action_pressed("Left"):
		direction -= camera.basis[0]

	direction.y = 0
	direction = direction.normalized()

	velocity.y += delta * gravity

	var hv = velocity
	hv.y = 0

	var new_pos = direction * SPEED
	var accel = DE_ACCELERATION

	if (direction.dot(hv) > 0):
		accel = ACCELERATION
	
	hv = hv.linear_interpolate(new_pos, accel * delta)
	velocity.x = hv.x
	velocity.z = hv.z
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	
func AnimationLoop():
	pass
