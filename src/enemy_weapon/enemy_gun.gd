extends Area2D

func _physics_process(delta):
	if global_rotation > -PI/2 and global_rotation < PI/2:
		scale.y = 1
	else:
		scale.y = -1
	var targets_in_range = get_overlapping_bodies()
	if targets_in_range.size() > 0:
		var cur_target = targets_in_range[0]
		look_at(cur_target.global_position)
		%EnemyShoot.start(0.001)
	
func shoot():
	var new_bullet = preload("res://src/bullet/enemy_bullet.tscn").instantiate()
	new_bullet.global_position = %ShootPoint.global_position
	new_bullet.global_rotation = %ShootPoint.global_rotation
	print("!")
	%ShootPoint.add_child(new_bullet)


func _on_enemy_shoot_timeout():
	shoot()
	$EnemyShoot.stop()
