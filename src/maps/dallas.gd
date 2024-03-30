extends Node2D
var entered = false

func _on_area_2d_body_entered(body: CharacterBody2D):
	entered = true	

func _on_area_2d_body_exited(body: CharacterBody2D):
	entered = false

func _physics_process(delta):
	if entered == true:
		if Input.is_action_just_pressed("next_level"):
			var next_scene = load("res://src/maps/brooklyn.tscn")
			get_tree().change_scene_to_packed(next_scene)
