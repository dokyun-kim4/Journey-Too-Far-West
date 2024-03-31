extends Node2D

func _physics_process(delta):
	%StartWukong.play()
	
func _on_quit_pressed():
	get_tree().quit()

func _on_start_pressed():
	var next_scene = load("res://src/maps/brooklyn.tscn")
	get_tree().change_scene_to_packed(next_scene)
	
func _on_controls_pressed():
	var next_scene = load("res://src/maps/controls.tscn")
	get_tree().change_scene_to_packed(next_scene)
