extends Area2D

@export var speed = 300

var movement_vector := Vector2(0,-1)

# Faz a movimentação da bala
func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
	



# TODO: Sumir quando atirar numa parede
# Faz a bala sumir quando bater em algum obstáculo
func _on_body_entered(body):
	if body.is_in_group("players"):
		# Tirar vida do player
		print("Toma dano ae otario >:D")
	queue_free()
