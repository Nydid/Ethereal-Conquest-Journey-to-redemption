extends Node2D

export var fire_rate = 1007
var ammo = 10
var can_fire = true

func _ready():
	$Timer.wait_time = fire_rate
	$Timer.start()
	set_process_input(true)

func _on_Timer_timeout():
	print("Timer timed out")
	can_fire = true

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		fire()

func fire():
	if can_fire and ammo > 0:
		var bullet_scene = preload("res://Scenes/bullet.tscn")
		var bullet = bullet_scene.instance()
		bullet.position = global_position + Vector2(20, 0)
		get_parent().add_child(bullet)
		ammo -= 1
		can_fire = false
		$Timer.start()
		
		
