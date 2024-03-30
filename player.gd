extends CharacterBody2D

const PLAYER_BASE_SPEED = 600

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * PLAYER_BASE_SPEED
	move_and_slide()
