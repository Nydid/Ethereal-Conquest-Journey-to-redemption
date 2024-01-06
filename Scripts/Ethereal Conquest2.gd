extends Node2D

var enemy_scene = preload("res://Scenes/enemy_scene2.tscn")
var game_over = preload("res://Scenes/GameOver.tscn")
var enemy_killed = 0
#HERE WE GET A REFERENCE TO OUR INITIAL ENEMY IN THE SCENE
@onready var enemy = $Player2
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	#HERE WE ARE CONNECTING THE ENEMY SIGNAL TO THIS NODE2D SCRIPT SO IT CAN RESPOND TO IT
	enemy.connect("enemy_killed", Callable(self, "_on_enemy_killed"))
	player.connect("player_dead", Callable(self, "_on_player_killed"))

# Spawn enemy
func spawn_enemy():
	enemy = enemy_scene.instantiate()
	add_child(enemy)
	#HERE WE NEED OUR NEWLY SPAWNED ENEMY TO HAVE THEIR SIGNAL CONNECTED TO OUR NODE2D TOP LEVEL SCRIPT SO WE CAN KEEP RESPAWNING UPON DEATH
	enemy.connect("enemy_killed", Callable(self, "_on_enemy_killed"))


# THIS IS THE METHOD THAT RESPONDS TO THE ENEMY_KILLED SIGNAL WHEN IT IS EMITTED
func _on_enemy_killed():
	print("I received the enemy killed signal")
	await get_tree().create_timer(1.0).timeout
	spawn_enemy()
	enemy_killed += 1
	if enemy_killed > 3 :
		get_tree().create_timer(3.0)
		get_tree().change_scene_to_file("res://Scenes/SceneHell.tscn")
func gameover():
	var game_over_node = game_over.instantiate()
	add_child(game_over_node)

func _on_player_killed():
	print("the player is quite dead")
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
