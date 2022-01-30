extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var anim = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Default")
	anim.playback_speed = 1.2



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
