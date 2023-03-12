extends KinematicBody2D

var bullet_scene = preload("res://Scenes/bullet.tscn")
export var speed = 100
var shoot
var health = 3
var isLive=true
var red_c=true

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
	shoot =Input.is_action_just_pressed("fire")
	if shoot:
		fire()
		
func fire():
	var new_bullet=bullet_scene.instance() 
	new_bullet.position = global_position + Vector2(40, 0)
	add_child(new_bullet)

func hit_by_bullet(pos):
	if !isLive:
		return
	health -=1
	
	if health<0 :
		isLive=false
		queue_free()
	
	
	  
