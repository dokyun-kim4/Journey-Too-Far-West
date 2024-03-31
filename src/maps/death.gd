extends Node2D

func _on_button_pressed():
	var next_scene = load("res://src/maps/brooklyn.tscn")
	get_tree().change_scene_to_packed(next_scene)
