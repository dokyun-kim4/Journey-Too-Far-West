extends CanvasLayer

var direction_up = true
var can_move = true
var format_string = "%s/8" 

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
	$Label.text = format_string % %BuddhaButtonAnimation.frame

func _on_brooklyn_karma_inc():
	%BuddhaButtonAnimation.frame += 1
func _on_dallas_karma_inc():
	%BuddhaButtonAnimation.frame += 1
func _on_los_angeles_karma_inc():
	%BuddhaButtonAnimation.frame += 1

func _on_brooklyn_karma_activate():
	%BuddhaButtonAnimation.modulate.a = 1
func _on_dallas_karma_activate():
	%BuddhaButtonAnimation.modulate.a = 1
func _on_los_angeles_karma_activate():
	%BuddhaButtonAnimation.modulate.a = 1

func _on_brooklyn_karma_reset():
	%BuddhaButtonAnimation.modulate.a = 0.5
	%BuddhaButtonAnimation.frame = 0
func _on_dallas_karma_reset():
	%BuddhaButtonAnimation.modulate.a = 0.5
	%BuddhaButtonAnimation.frame = 0
func _on_los_angeles_karma_reset():
	%BuddhaButtonAnimation.modulate.a = 0.5
	%BuddhaButtonAnimation.frame = 0


func _on_button_animation_timer_timeout():
	can_move = true
