extends Area2D

@export var speed = 300

var movement_vector := Vector2(0,-1)


func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
	


