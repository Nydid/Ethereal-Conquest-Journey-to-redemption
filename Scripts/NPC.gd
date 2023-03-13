extends KinematicBody2D

var bullet_scene = preload("res://Scenes/bullet2.tscn")
var isLive=true
var health=1
var red_c = true
var enemy
var enemy_scene = load("res://Scenes/enemy_scene.tscn")
var shoot


func _physics_process(_delta):

	if Input.is_action_just_pressed("ui_down2"):
		if red_c == true:
			$CollisionShape2D.set_disabled(true)
			red_c = false
		else:
			$CollisionShape2D.set_disabled(false)
			red_c = true
			
	if !isLive:
		return
	shoot =Input.is_action_just_pressed("fire2") 
	if shoot:
		fire()

func _ready():
	GameManager.player.call_from_NPC()
	pass

func spawnenemy():
	enemy = enemy_scene.instance()
	add_child(enemy)
	
	
func removeenemy():
	if enemy: 
		enemy.queue_free()
	spawnenemy()
		
	
func hit_by_bullet(_pos):
	if !isLive:
		return
	health -=1
	
	if health<0 :
		isLive=false
		queue_free()
		#removeenemy()
		
func fire():
	var new_bullet=bullet_scene.instance() 
	new_bullet.position = global_position + Vector2(-40, 0)
	add_child(new_bullet)


