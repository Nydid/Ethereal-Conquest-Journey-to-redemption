extends KinematicBody2D

export var speed = 100

func _physics_process(delta):
	var velocity = Vector2()

	if Input.is_action_pressed("ui_down"):
		velocity.y += 1

	velocity = velocity.normalized() * speed
	var collision = move_and_collide(velocity * delta)
