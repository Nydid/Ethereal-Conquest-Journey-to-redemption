extends Node
var time_elapsed:float = 0.0
var secret_main_menu:bool = false

func _process(delta: float) -> void:
	time_elapsed += delta

var player

