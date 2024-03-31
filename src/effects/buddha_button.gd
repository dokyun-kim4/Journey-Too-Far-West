extends CanvasLayer

func _on_brooklyn_karma_inc():
	%BuddhaButtonAnimation.frame += 1

func _on_brooklyn_karma_activate():
	%BuddhaButtonAnimation.modulate.a = 1

func _on_brooklyn_karma_reset():
	%BuddhaButtonAnimation.modulate.a = 0.5
	%BuddhaButtonAnimation.frame = 0
