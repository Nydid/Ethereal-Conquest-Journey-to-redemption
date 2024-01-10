extends Node
var player

var time_elapsed:float = 0.0
var secret_main_menu:bool = false

func _ready() -> void:
	reset_time()
	set_process(false)
	
	
func _process(delta: float) -> void:
	#Internal timer, could be used as a level timer but currently I'm only using it to check for easter egg conditions
	time_elapsed += delta
	
func get_time() -> float:
	return time_elapsed
	
func reset_time() -> void:
	time_elapsed = 0.0



