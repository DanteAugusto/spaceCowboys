extends Node2D

func _on_body_entered(body):
	if body.is_in_group("players"):
		# Tirar vida do player
		body.take_damage(1, - body.get_real_velocity())
