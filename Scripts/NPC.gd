extends KinematicBody2D

#HERE IS THE FIRST ADDED LINE WHERE YOU DECLARE THE SIGNAL
signal enemy_killed

var bullet_scene = preload("res://Scenes/bullet2.tscn")


var isLive = true
var health = 4
var red_c = true
var enemy_killed = 0
var shoot_timer = 0.0
var crouch_timer = 0.0

# Physics process
func _physics_process(delta):
	
	shoot_timer += delta
	crouch_timer += delta

	# Crouch every 2 seconds
	if crouch_timer >= 2.0:
		crouch_timer = 0.0
		toggle_crouch()

	# Shoot every 1 second
	if shoot_timer >= 1.0:
		shoot_timer = 0.0
		fire()

# Toggle crouch
func toggle_crouch():
	$CollisionShape2D.set_disabled(!red_c)
	red_c = !red_c

# Fire a bullet
func fire():
	var new_bullet = bullet_scene.instance()
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
		#HERE IS THE SECOND ADDED LINE WHERE THE ENEMY EMITS THE             SIGNAL
		emit_signal("enemy_killed")
		queue_free()
