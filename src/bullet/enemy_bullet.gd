extends Area2D

const BULLET_SPEED = 1000
const BULLET_RANGE = 1200
var travelled_dist = 0;

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * delta * BULLET_SPEED
	travelled_dist += BULLET_SPEED * delta
	if travelled_dist > BULLET_RANGE:
		queue_free()

func _on_body_entered(body):
	print("shot!")
	queue_free()
	if body.has_method("take_damage_player"):
		body.take_damage_player()
