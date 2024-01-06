extends Area2D

@export var bulletSpeed: int

func _ready():
	set_as_top_level(true)
	
func _process(delta):
	if is_outside_view_bounds():
		queue_free()
	move_local_x(delta*bulletSpeed)

func is_outside_view_bounds():
	return position.x>DisplayServer.screen_get_size().x or position.x<0.0\
		or position.y>DisplayServer.screen_get_size().y or position.y<0.0 


func _on_Bullet_body_entered(body):
	if body.get_collision_layer_value(2):
		body.hit_by_bullet(body.position)
	queue_free()
	
