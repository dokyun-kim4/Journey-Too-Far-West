extends Node2D

var car_activate = false
var stage_clear = false

const MAX_MOBS = 2
var mob_count = 0
var killed = 0

func _ready():
	%car.hide()

func _physics_process(delta):
	if car_activate == true and stage_clear == true:
		if Input.is_action_just_pressed("next_level"):
			var next_scene = load("res://src/maps/dallas.tscn")
			get_tree().change_scene_to_packed(next_scene)

func spawn_mob():
	var new_mob = preload("res://src/mobs/melee_mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
	new_mob.mob_dead.connect(_on_mob_dead)
	
func _on_area_2d_body_entered(body):
	car_activate = true
	
func _on_area_2d_body_exited(body):
	car_activate = false
	
func _on_timer_timeout():
	if mob_count < MAX_MOBS:
		spawn_mob()
		mob_count += 1
		%SpawnTimer.wait_time = randf_range(2.0, 5.0)
		print("Time until next spawn: ", %SpawnTimer.wait_time)		

func _on_mob_dead():
	killed += 1
	if killed == MAX_MOBS:
		%car.show()
		stage_clear = true


