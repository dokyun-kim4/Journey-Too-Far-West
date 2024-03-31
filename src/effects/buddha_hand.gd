extends Area2D

func _on_body_entered(body):
	if body.has_method("take_damage_buddha"):
		body.take_damage_buddha()

func _physics_process(delta):
	%BuddhaStrikeImprint.z_index = -1
	%BuddhaAnimation.hand_slam()
	
	if %BuddhaAnimation.frame == 8:
		%BuddhaStrikeImprint.visible = true
		%BuddhaAnimation.visible = false
