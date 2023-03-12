extends KinematicBody2D

export var speed = 100
var isLive=true
var health=2
var red_c = true
var enemy
var enemy_scene = load("res://Scenes/enemy_scene.tscn")
func _physics_process(delta):
	var velocity = Vector2()

	if Input.is_action_just_pressed("ui_down"):
		if red_c == true:
			$CollisionShape2D.set_disabled(true)
			red_c = false
		else:
			$CollisionShape2D.set_disabled(false)
			
			red_c = true
	var collision = move_and_collide(velocity * delta)
	if !isLive:
		return 
func hit_by_bullet(pos):
	if !isLive:
		return
	health -=1
	
	if health<0 :
		isLive=false
		queue_free()
		#removeenemy()
		
func spawnenemy():
	enemy = enemy_scene.instance()
	add_child(enemy)
	
	
func removeenemy():
	if enemy: 
		enemy.queue_free()
	spawnenemy()
