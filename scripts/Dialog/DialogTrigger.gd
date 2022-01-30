extends Node

onready var DialogScene = preload("res://scenes/Game/Dialog/DialogBox.tscn")

func _ready():
	pass 

func _on_Choice_body_entered(body):
	print("entered tile shape")
	var new_dialog = DialogScene.instance()
	add_child(new_dialog)
	new_dialog.start()
