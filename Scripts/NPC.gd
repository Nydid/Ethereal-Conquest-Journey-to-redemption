extends KinematicBody2D

var bullet_scene = preload("res://Scenes/bullet2.tscn")
var enemy_scene = load("res://Scenes/enemy_scene.tscn")

var isLive = true
var health = 4
var red_c = true
var enemy_killed = 0
var next_enemy_time = 0.0
var enemy
var shoot_timer = 0.0
var crouch_timer = 0.0

# Physics process
func _physics_process(delta):
	if !isLive:
		return

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

	# Check if it's time to spawn the next enemy
	if enemy_killed > 0 and OS.get_ticks_msec() > next_enemy_time:
		spawnenemy()
		enemy_killed += 1
		next_enemy_time = OS.get_ticks_msec() + 1000

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
		spawnenemy()
		queue_free()

# Spawn enemy
func spawnenemy():
	var new_enemy = enemy_scene.instance()
	add_child(new_enemy)

# Remove enemy
func removeenemy():
	if enemy:
		enemy.queue_free()
	spawnenemy()
