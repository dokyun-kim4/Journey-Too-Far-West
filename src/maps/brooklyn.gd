extends Node2D

var car_activate = false
const MAX_MOBS = 20
var killed = 0

func _physics_process(delta):
	if car_activate == true:
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
	print("Mob Spawned")
	spawn_mob()
	%SpawnTimer.wait_time = randf_range(2.0, 5.0)
	print("Time until next spawn: ", %SpawnTimer.wait_time)

func _on_mob_dead():
	print("BRRRRRRRR")


