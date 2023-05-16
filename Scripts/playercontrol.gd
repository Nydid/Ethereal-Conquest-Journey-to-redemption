extends KinematicBody2D

var bullet_scene = preload("res://Scenes/bullet.tscn")

var shoot
var health = 3
var isLive=true
var is_crouching = false
var red_c=true
var original_sprite_size = Vector2(0, 0)

func _ready():
	GameManager.player=self
	original_sprite_size = $Sprite.texture.get_size()

func _physics_process(_delta):
	
	if Input.is_action_pressed("ui_down"):
		crouch()
	else:
		stand_up()
		if shoot:
			fire()
			
	if !isLive:
		return
	shoot = Input.is_action_just_pressed("fire")

	
	
func crouch():
	if red_c:
		var new_size = original_sprite_size
		new_size.y /= 2
		#$Sprite.texture_rect_size = new_size
		$CollisionShape2D.set_disabled(true)
		red_c = false

func stand_up():
	if !red_c:
		#$Sprite.texture_rect_size = original_sprite_size
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
	
	if health<0 :
		isLive=false
		queue_free()
		
func call_from_NPC():
	print("Zombie")
