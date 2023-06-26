extends Node2D


@onready var play := $player as CharacterBody2D
func _physics_process(delta):
	if Input.is_key_pressed(KEY_L):
		play.rotate(3*PI/2)
