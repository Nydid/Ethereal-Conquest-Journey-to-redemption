extends Control

@onready var rect:TextureRect = $TextureRect
var secret_menu1 = preload("res://Art/StartGame1.png")
var secret_menu2 = preload("res://Art/Startgame2.png")
var secret_menus = [secret_menu1, secret_menu2]
var secret_screens = secret_menus[randi() % secret_menus.size()]

func _ready() -> void:
	#Easter egg start screen variable from the game manager.
	if GameManager.secret_main_menu == true:
		rect.texture = secret_screens
	pass

#Unhandled input respects UI related things so it's usually a better choice\
#you should also always use the built in input mapper, this leaves things modular.
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("fire"):
		get_tree().change_scene_to_file("res://Scenes/Ethereal Conquest.tscn")
		GameManager.secret_main_menu = false
		GameManager.set_process(true)
		GameManager.reset_time()
