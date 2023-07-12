extends Area2D

@export var speed = 300

@onready var wall_detector := $wall_detector as RayCast2D
var movement_vector := Vector2(0,-1)

# Faz a movimentação da bala
func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
	
	if wall_detector.is_colliding():
		queue_free()
	

# Faz a bala sumir quando bater em algum obstáculo
func _on_body_entered(body):
	if body.is_in_group("players"):
		# Tirar vida do player
		body.take_damage(1, movement_vector.rotated(rotation) * speed)
	queue_free()
