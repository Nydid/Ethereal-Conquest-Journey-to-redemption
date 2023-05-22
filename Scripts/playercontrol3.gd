extends KinematicBody2D

var bullet_scene = preload("res://Scenes/bullet.tscn")

var max_bullets = 8
var current_bullets = max_bullets
var shoot
var health = 3
var isLive=true
var is_crouching = false
var red_c=true
var original_sprite_size = Vector2(0, 0)

signal player_dead

	
func _ready():
	GameManager.player=self
	original_sprite_size = $Sprite.texture.get_size()
	

func _physics_process(_delta):
	
	if Input.is_action_pressed("ui_down"):
		crouch()
	else:
		stand_up()
		if shoot and current_bullets > 0:
			fire()
			current_bullets -= 1
			get_parent().get_node("Lives&Ammo").get_node("balle").text = var2str(get_parent().get_node("Player").current_bullets)
			
	if Input.is_action_just_pressed("ui_up"):
		reload()
		get_parent().get_node("Lives&Ammo").get_node("balle").text = var2str(get_parent().get_node("Player").current_bullets)

	if !isLive:
		return
	shoot = Input.is_action_just_pressed("fire")

func crouch():
	if red_c:
		var new_size = original_sprite_size
		new_size.y /= 2
		$Sprite.texture = load("res://Art/hellcrouch.png")
		$Sprite.position.y = 54
		$Ourfinalgun.position.y = 45
		$CollisionShape2D.set_disabled(true)
		red_c = false

func stand_up():
	if !red_c:
		$Sprite.texture = load("res://Art/hellstand.png")
		$Sprite.position.y = 32
		$Ourfinalgun.position.y = 1
		$CollisionShape2D.set_disabled(false)
		red_c = true

func fire():
	var new_bullet=bullet_scene.instance() 
	new_bullet.position = global_position + Vector2(40, 0)
	add_child(new_bullet)

func hit_by_bullet(_pos):
	if !isLive:
		return
	health -=1
	get_parent().get_node("Lives&Ammo").get_node("health").text = var2str(get_parent().get_node("Player").health)
	
	if health<1 :
		isLive=false
		emit_signal("player_dead")
		queue_free()
		
func reload():
	current_bullets = max_bullets