extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_animated_sprite.play("title")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

onready var _animated_sprite = $AnimatedSprite

#func _process(_delta):
#	if !_animated_sprite.is_playing():
#		_animated_sprite.play("title")
#		if _animated_sprite.frame == 3:
#			_animated_sprite.stop()
