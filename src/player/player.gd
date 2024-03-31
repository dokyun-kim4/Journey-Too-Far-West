extends CharacterBody2D

signal player_dead
signal karma_used

var health = 100.0
var cur_facing = Vector2.RIGHT
var karma_enabled = false

const PLAYER_BASE_SPEED = 350
const SPRINT_MULTIPLIER = 2
const DAMAGE_RATE = 5.0

func ready():
	karma_used.connect(get_parent()._on_karma_used)

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
	if abs(direction.x) > 0 or abs(direction.y) > 0:
		cur_facing = direction
	
	if Input.is_action_pressed("sprint"):
		velocity = cur_facing * PLAYER_BASE_SPEED * SPRINT_MULTIPLIER
	else: 
		velocity = direction * PLAYER_BASE_SPEED 
	move_and_slide()
	
	if Input.is_action_pressed("buddha_hand"):
		karma_used.emit()
	
	if velocity.length() > 0.0:
		if sign(direction.y) > 0:
			%Wukong_Animations.walk_forward_animation()
		elif sign(direction.y) < 0:
			%Wukong_Animations.walk_backward_animation()
		elif sign(direction.x) < 0:
			%Wukong_Animations.walk_left_animation()
		else:
			%Wukong_Animations.walk_right_animation()
	else:
		%Wukong_Animations.stop()
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%HealthBar.value = health
	
	if health <= 0.0:
		player_dead.emit()

func _on_brooklyn_karma_activate():
	karma_enabled = true
	
func take_damage():
	health -= 0.1
	%HealthBar.value = health
	
	if health == 0:
		player_dead.emit()
