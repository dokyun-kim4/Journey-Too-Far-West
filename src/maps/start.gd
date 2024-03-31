extends Node2D

func _on_quit_pressed():
	get_tree().quit()

func _on_start_pressed():
	var next_scene = load("res://src/maps/brooklyn.tscn")
	get_tree().change_scene_to_packed(next_scene)
