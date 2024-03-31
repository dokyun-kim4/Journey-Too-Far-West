# BROOKLYN SCRIPT
extends Node2D

signal karma_activate

const MIN_SPAWN_TIME = 2.0
const MAX_SPAWN_TIME = 5.0
const MAX_MOBS = 10
const KARMA_MAX = 1

var mob_count = 0
var killed = 0
var karma_kill = 0

var car_activate = false
var stage_clear = false

var buddha_hand

func _ready():
	%Car.hide()
	%CityName.show()
	#%BrooklynPlayer.karma_used.connect(_on_karma_used())

func _physics_process(delta):
	if car_activate == true and stage_clear == true:
		if Input.is_action_just_pressed("next_level"):
			var next_scene = load("res://src/maps/dallas.tscn")
			get_tree().change_scene_to_packed(next_scene)
	
	if karma_kill == KARMA_MAX:
		karma_activate.emit()

func spawn_mob():
	var new_mob = preload("res://src/mobs/melee_mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
	new_mob.mob_dead.connect(_on_mob_dead)

func _on_display_timer_timeout():
	%CityName.hide()
	
func _on_car_body_entered(body):
	car_activate = true

func _on_car_body_exited(body):
	car_activate = false
	
func _on_spawn_timer_timeout():
	if mob_count < MAX_MOBS:
		spawn_mob()
		mob_count += 1
		%SpawnTimer.wait_time = randf_range(MIN_SPAWN_TIME, MAX_SPAWN_TIME)
		print("Time until next spawn: ", %SpawnTimer.wait_time)		

func _on_mob_dead():
	killed += 1
	karma_kill += 1
	if killed == MAX_MOBS:
		%Car.show()
		stage_clear = true

func _on_brooklyn_player_karma_used():
	karma_kill = 0
	buddha_hand = preload("res://src/effects/buddha_hand.tscn").instantiate()
	buddha_hand.global_position = get_global_mouse_position()
	add_child(buddha_hand)
	%BuddhaTimer.start(1.0)

func _on_buddha_timer_timeout():
	%BuddhaTimer.stop()
	remove_child(buddha_hand)
	
