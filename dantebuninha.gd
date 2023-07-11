extends Node2D


@onready var gun := $gun
@onready var gun2 := $gun2
@onready var play := $player
@onready var play2 := $player2

# Posiciona as armas ao lado dos players
func _process(delta):
	gun.global_position = play.global_position
	gun2.global_position = play2.global_position
