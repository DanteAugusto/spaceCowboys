extends Node2D


@onready var gun := $gun
@onready var gun2 := $gun2
@onready var play := $player
@onready var play2 := $player2

var playAlive := true
var play2Alive := true
var is_round_finished := false
signal round_ended



# Posiciona as armas ao lado dos players
func _process(delta):
	if(playAlive):
		gun.global_position = play.global_position
	if(play2Alive):
		gun2.global_position = play2.global_position



func _on_player_is_dead():
	playAlive = false
	gun.queue_free()
	play.queue_free()
	round_ended.emit()


func _on_player_2_is_dead():
	play2Alive = false
	gun2.queue_free()
	play2.queue_free()
	round_ended.emit()


# TODO: Mudar para outro mapa
# TODO: Verif
func _on_round_ended():
	if(!is_round_finished):
		is_round_finished = true
		print("Round acabou! O vencedor é...")
		if(playAlive):
			print("Player1!")
			Global.update_score(1)
		elif(play2Alive):
			print("Player2!")
			Global.update_score(2)
		else:
			print("Ninguém?")
		print("Indo para a proxima partida...")
		
		Global.change_map()
		pass # Replace with function body.
