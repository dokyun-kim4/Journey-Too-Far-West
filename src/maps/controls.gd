extends Node2D

func _physics_process(delta):
	%StartWukong.play()

func _on_back_pressed():
	var next_scene = load("res://src/maps/start.tscn")
	get_tree().change_scene_to_packed(next_scene)
