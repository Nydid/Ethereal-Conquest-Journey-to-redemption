extends KinematicBody2D

var bullet_scene = preload("res://Scenes/bullet.tscn")
export var speed = 100
var shoot

func _physics_process(delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_down"):
		
		velocity.y += 1
	velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity * delta)
	shoot =Input.is_action_just_pressed("fire")
	if shoot:
		fire()
func fire():
	var new_bullet=bullet_scene.instance() 
	new_bullet.position = global_position + Vector2(40, 0)
	add_child(new_bullet)
	
	
	  
