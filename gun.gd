extends Area2D

func _physics_process(delta):
	var targets_in_range = get_overlapping_bodies()
	if targets_in_range.size() > 0:
		var cur_target = targets_in_range[0]
		look_at(cur_target.global_position)
