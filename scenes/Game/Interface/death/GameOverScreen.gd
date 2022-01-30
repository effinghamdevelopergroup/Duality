extends CanvasLayer


func _on_RestartButton_pressed():
	get_tree().change_scene("res://scenes/Game/World.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
