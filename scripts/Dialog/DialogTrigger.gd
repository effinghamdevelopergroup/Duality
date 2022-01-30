extends Node

onready var DialogScene = preload("res://scenes/Game/Dialog/DialogBox.tscn")
var new_dialog

func _ready():
	pass 

func _on_Choice_body_entered(body):
	new_dialog = DialogScene.instance()
	add_child(new_dialog)
	new_dialog.show()

func _on_Choice_body_exited(body):
	if (new_dialog != null):
		new_dialog.hide()
