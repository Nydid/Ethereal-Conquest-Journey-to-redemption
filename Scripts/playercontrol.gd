extends KinematicBody2D

var bullet_scene = preload("res://Scenes/bullet.tscn")

var shoot
var health = 3
var isLive=true
var is_crouching = false
var red_c=true

func _ready():
	GameManager.player=self
	
func _physics_process(_delta):
	if Input.is_action_pressed("ui_down"):
		set_crouch(true)
	else:
		set_crouch(false)
			
	if !isLive:
		return
	shoot =Input.is_action_just_pressed("fire")
	if shoot:
		fire()
	
func set_crouch(crouch):
	if crouch:
		if red_c:
			$CollisionShape2D.set_disabled(true)
			red_c = false
			is_crouching = true
	else:
		if !red_c:
			$CollisionShape2D.set_disabled(false)
			red_c = true
			is_crouching = false
func fire():
	var new_bullet=bullet_scene.instance() 
	new_bullet.position = global_position + Vector2(40, 0)
	add_child(new_bullet)

func hit_by_bullet(_pos):
	if !isLive:
		return
	health -=1
	
	if health<0 :
		isLive=false
		queue_free()
		
func call_from_NPC():
	print("Zombie")
	
	
	  
