extends Control
var return_to_menu:int


func _ready() -> void:
	GameManager.set_process(false)
	if GameManager.time_elapsed <= 38:
		GameManager.secret_main_menu = true
	print(GameManager.time_elapsed)

func _process(_delta: float) -> void:
	if return_to_menu >= 3:
		get_tree().change_scene_to_file("res://Scenes/StartGame.tscn")

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("fire"):
		return_to_menu += 1

