extends Node2D

var enemy_scene = preload("res://Scenes/enemy_scene.tscn")
#HERE WE GET A REFERENCE TO OUR INITIAL ENEMY IN THE SCENE
onready var enemy = $Player2

# Called when the node enters the scene tree for the first time.
func _ready():
	#HERE WE ARE CONNECTING THE ENEMY SIGNAL TO THIS NODE2D SCRIPT SO IT CAN RESPOND TO IT
	enemy.connect("enemy_killed", self, "_on_enemy_killed")

# Spawn enemy
func spawn_enemy():
	if enemy == null:
		enemy = enemy_scene.instance()
		add_child(enemy)
		#HERE WE NEED OUR NEWLY SPAWNED ENEMY TO HAVE THEIR SIGNAL CONNECTED TO OUR NODE2D TOP LEVEL SCRIPT SO WE CAN KEEP RESPAWNING UPON DEATH
		enemy.connect("enemy_killed", self, "_on_enemy_killed")

# Remove enemy
func remove_enemy():
		enemy.queue_free()

# THIS IS THE METHOD THAT RESPONDS TO THE ENEMY_KILLED SIGNAL WHEN IT IS EMITTED
func _on_enemy_killed():
  remove_enemy()
  spawn_enemy()
