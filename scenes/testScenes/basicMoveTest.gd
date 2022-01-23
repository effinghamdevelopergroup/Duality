extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector3()

export var moveSpeed = 5
export var gravity = Vector3.DOWN * 10
export var rot_speed = 0.9
onready var anim = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("move")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector3.ZERO
	var horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var vertical = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#velocity +=transform.basis.z * moveSpeed * vertical	
	if horizontal<0:
		rotation.y = -PI*.5
	elif horizontal>0:
		rotation.y = PI*.5
	if vertical<0:
		rotation.y = PI
	elif vertical>0:
		rotation.y = 0
		
	velocity.z +=  moveSpeed * vertical
	velocity.x +=  moveSpeed * horizontal

	#rotate_y(rot_speed*horizontal*delta)	
		
	velocity +=gravity
	
	move_and_slide(velocity,Vector3.DOWN)
