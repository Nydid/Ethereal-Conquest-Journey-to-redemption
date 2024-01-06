extends Control

#Unhandled input respects UI related things so it's usually a better choice\
#you should also always use the built in input mapper, this leaves things modular.
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("fire"):
		get_tree().change_scene_to_file("res://Scenes/Ethereal Conquest.tscn")
