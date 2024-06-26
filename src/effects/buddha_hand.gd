extends Area2D

@onready var buddha_slam = $BuddhaSound
var do_dmg = true

func _on_body_entered(body):
	if do_dmg:
		if body.has_method("take_damage_buddha"):
			body.take_damage_buddha()

func _physics_process(delta):
	%BuddhaStrikeImprint.z_index = -1
	%BuddhaAnimation.hand_slam()
	
	if %BuddhaAnimation.frame == 8:
		%BuddhaStrikeImprint.visible = true
		%BuddhaAnimation.visible = false
		do_dmg = false
