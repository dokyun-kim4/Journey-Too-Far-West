extends CharacterBody2D

signal player_dead

var health = 100.0
var cur_facing = Vector2.RIGHT

const PLAYER_BASE_SPEED = 600
const SPRINT_MULTIPLIER = 2
const DAMAGE_RATE = 5.0

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	#if sign(cur_facing.x) != sign(direction.x) and direction.x != 0: 
		#scale.x = -1
		
	if abs(direction.x) > 0 or abs(direction.y) > 0:
		cur_facing = direction
	
	if Input.is_action_pressed("sprint"):
		velocity = cur_facing * PLAYER_BASE_SPEED * SPRINT_MULTIPLIER
	else: 
		velocity = direction * PLAYER_BASE_SPEED 
	move_and_slide()
	
	if velocity.length() > 0.0:
		%wukong_forward.walk_forward_animation()
	else:
		%wukong_forward.stop()
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%HealthBar.value = health
	
	if health <= 0.0:
		player_dead.emit()

	
		
