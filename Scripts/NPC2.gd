extends CharacterBody2D

# Declare the signal
signal enemy_killed

var bullet_scene = preload("res://Scenes/bullet2.tscn")

var isLive = true
var health = 4
var red_c = true
var enemy_killed = 0
var shoot_timer = 0.0
var crouch_timer = 0.0
var isCrouched = false

# Declare the crouch and stand up textures
var crouch_texture = load("res://Art/enemcrouchearth.png")
var stand_up_texture = load("res://Art/enemstandearth.png")

# Physics process
func _physics_process(delta):
	shoot_timer += delta
	crouch_timer += delta
	# Crouch every 2 seconds if not already crouched
	if crouch_timer >= 1.5 :
		crouch_timer = 0.0
		toggle_crouch()
	if isCrouched:
		$Sprite2D.texture = crouch_texture
		$Sprite2D.position.y = 50
		$Gun/shotgun.position.y = 45
	else:
		$Sprite2D.texture = stand_up_texture

		$Gun/shotgun.position.y = 0.1
		$Sprite2D.position.y = 22

	# Shoot every 1 second
	if shoot_timer >= 0.75 and !isCrouched:
		shoot_timer = 0.0
		fire()

# Toggle crouch
func toggle_crouch():
	if isCrouched:
		$CollisionShape2D.set_disabled(false)
		$Gun/shotgun.position.y = 20
		isCrouched = false
	else:
		$CollisionShape2D.set_disabled(true)
		isCrouched = true
		

# Fire a bullet
func fire():
	var new_bullet = bullet_scene.instantiate()
	new_bullet.position = global_position + Vector2(-40, 0)
	add_child(new_bullet)

# Decrease health when hit by a bullet
func hit_by_bullet(_pos):
	if !isLive:
		return

	health -= 1
	if health < 0:
		isLive = false
		enemy_killed += 1
		# Emit the signal when the enemy is killed
		emit_signal("enemy_killed")
		queue_free()
