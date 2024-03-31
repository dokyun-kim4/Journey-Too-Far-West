extends Area2D

func _physics_process(delta):
	%WeaponAnimation.gun_idle()
	look_at(get_global_mouse_position())
	if global_rotation > -PI/2 and global_rotation < PI/2:
		scale.y = 1
	else:
		scale.y = -1
	#var targets_in_range = get_overlapping_bodies()
	#if targets_in_range.size() > 0:
		#var cur_target = targets_in_range[0]
		#look_at(cur_target.global_position)
	if Input.is_action_pressed("shoot"):
		%ShootTimer.start(0.05)
	
func shoot():
	var new_bullet = preload("res://src/bullet/bullet.tscn").instantiate()
	new_bullet.global_position = %ShootPoint.global_position
	new_bullet.global_rotation = %ShootPoint.global_rotation
	%ShootPoint.add_child(new_bullet)

func _on_shoot_timer_timeout():
	shoot()
	%ShootTimer.stop()
