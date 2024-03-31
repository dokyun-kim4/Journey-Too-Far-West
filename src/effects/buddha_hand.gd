extends Area2D

func _on_body_entered(body):
	if body.has_method("take_damage_buddha"):
		body.take_damage_buddha()
