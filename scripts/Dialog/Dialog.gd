extends Node

onready var text_area = $RichTextLabel
var dialog = {"FireOrIce":["Old Man", "Fire... or... Ice?",["Fire", "Ice"]]}
var page = 0
signal learn_ability

func _ready():
	var speaker_name_length = dialog["FireOrIce"][0].length()
	text_area.set_bbcode(dialog["FireOrIce"][0] + ": " + dialog["FireOrIce"][1])
	text_area.set_visible_characters(speaker_name_length)
	$AudioStreamPlayer.play()
	for value in dialog["FireOrIce"][2]:
		var button = Button.new()
		button.text = value
		button.connect("pressed", self, value)
		button.margin_left = 15
		$ButtonArea.add_child(button)

func learn_ability(choice):
	AbilityDatabase.Choice = choice

func Fire():
	print("Picked Fire")
	learn_ability("Fireball")
	
func Ice():
	print("Picked Ice")
	learn_ability("Icelance")

func _on_Timer_timeout():
	text_area.set_visible_characters(text_area.get_visible_characters() + 1)
