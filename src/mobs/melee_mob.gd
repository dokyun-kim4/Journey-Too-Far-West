extends CharacterBody2D
signal mob_dead
var health = 3
const REPEL = 0

@onready var player = get_node("../Player")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	var distance = global_position.distance_to(player.global_position)
	velocity = direction * 100.0
	if velocity.length() > 0:
			%Mob.play()
	if distance <= REPEL:
		direction = -direction
		velocity = direction * 100.0
	move_and_slide()
	
func take_damage_mob():
	health -= 1
	if health == 0:
		queue_free()
		explosion()

func explosion():
	const EXPLOSION = preload("res://src/effects/explosion.tscn")
	var explode = EXPLOSION.instantiate()
	get_parent().add_child(explode)
	explode.global_position = global_position
	mob_dead.emit()

func take_damage_buddha():
	health = 0
	queue_free()
	explosion()
