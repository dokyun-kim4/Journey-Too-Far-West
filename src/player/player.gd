extends CharacterBody2D

const PLAYER_BASE_SPEED = 600
const SPRINT_MULTIPLIER = 2
var cur_facing = Vector2(1,0)

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if sign(cur_facing.x) != direction.x and direction.x != 0: 
		scale.x = sign(direction.x)
	
	if abs(direction.x) > 0 or abs(direction.y) > 0:
		cur_facing = direction
	
	if Input.is_action_pressed("sprint"):
		velocity = cur_facing * PLAYER_BASE_SPEED * SPRINT_MULTIPLIER
	else: 
		velocity = direction * PLAYER_BASE_SPEED 

	move_and_slide()
