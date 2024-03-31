extends CharacterBody2D

signal player_dead
signal karma_used

var health = 100.0
var cur_facing = Vector2.RIGHT
var karma_enabled = false
var sprint_enabled = true

const PLAYER_BASE_SPEED = 350
const SPRINT_MULTIPLIER = 2
const DAMAGE_RATE = 5.0

@onready var walk_sound = $WalkingSound
@onready var dash_sound = $DashSound

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
	if abs(direction.x) > 0 or abs(direction.y) > 0:
		cur_facing = direction
	
	if sprint_enabled and Input.is_action_pressed("sprint"):
		velocity = cur_facing * PLAYER_BASE_SPEED * SPRINT_MULTIPLIER
		dash_sound.play()
		if %SprintTimer.time_left == 0:
			%SprintTimer.start(3.0)
			
		print(%SprintTimer.time_left)
		if %SprintTimer.time_left < 2.5 or Input.is_action_just_released("sprint"):
			sprint_enabled = false
	else: 
		velocity = direction * PLAYER_BASE_SPEED 
	move_and_slide()
	
	if Input.is_action_pressed("buddha_hand") and karma_enabled:
		karma_used.emit()
		karma_enabled = false
	
	if velocity.length() > 0.0:
		if $WalkingSound.get_playback_position() == 0.0:
			$WalkingSound.play()
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
		var next_scene = load("res://src/maps/death.tscn")
		get_tree().change_scene_to_packed(next_scene)

func _on_brooklyn_karma_activate():
	karma_enabled = true
	
func _on_dallas_karma_activate():
	karma_enabled = true
	
func _on_los_angeles_karma_activate():
	karma_enabled = true
	
func take_damage():
	health -= 0.1
	%HealthBar.value = health
	
	if health == 0:
		player_dead.emit()
		var next_scene = load("res://src/maps/death.tscn")
		get_tree().change_scene_to_packed(next_scene)

func _on_sprint_timer_timeout():
	sprint_enabled = true


