extends Control

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_ENTER:
		get_tree().change_scene("res://Scenes/Ethereal Conquest.tscn")
