extends CanvasLayer

var direction_up = true
var can_move = true

func _physics_process(delta):
	if can_move:
		if direction_up:
			%BuddhaButtonAnimation.position.y += 10
			%ButtonAnimationTimer.start(0.5)
			can_move = false
		else:
			%BuddhaButtonAnimation.position.y -= 10
			%ButtonAnimationTimer.start(0.5)
			can_move = false
		direction_up = !direction_up

func _on_brooklyn_karma_inc():
	%BuddhaButtonAnimation.frame += 1

func _on_brooklyn_karma_activate():
	%BuddhaButtonAnimation.modulate.a = 1

func _on_brooklyn_karma_reset():
	%BuddhaButtonAnimation.modulate.a = 0.5
	%BuddhaButtonAnimation.frame = 0


func _on_button_animation_timer_timeout():
	can_move = true
