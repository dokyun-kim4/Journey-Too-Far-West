# BROOKLYN SCRIPT
extends Node2D

signal karma_activate

const MIN_SPAWN_TIME = 2.0
const MAX_SPAWN_TIME = 5.0
const MAX_MOBS = 2
var mob_count = 0
var killed = 0
var karma_kill = 0

var car_activate = false
var stage_clear = false

func _ready():
	%Car.hide()
	%city_name.show()

func _physics_process(delta):
	if car_activate == true and stage_clear == true:
		if Input.is_action_just_pressed("next_level"):
			var next_scene = load("res://src/maps/dallas.tscn")
			get_tree().change_scene_to_packed(next_scene)
	
	if karma_kill == 10:
		karma_activate.emit()

func spawn_mob():
	var new_mob = preload("res://src/mobs/melee_mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
	new_mob.mob_dead.connect(_on_mob_dead)

func _on_title_timer_timeout():
	%city_name.hide()
	
func _on_area_2d_body_entered(body):
	car_activate = true

func _on_area_2d_body_exited(body):
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
		
func _on_karma_used():
	pass
	


