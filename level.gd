extends Node2D


@onready var gun := $gun
@onready var gun2 := $gun2
@onready var play := $player
@onready var play2 := $player2
@onready var timer := $timer

var waiting = false
var playAlive := true
var play2Alive := true
var is_round_finished := false
var rng : RandomNumberGenerator = RandomNumberGenerator.new()
signal round_ended

func _ready():
	play.initialize(0)
	play2.initialize(1)
	timer.one_shot = false
	timer.start(10)


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


func _on_timer_timeout():
	rng.randomize()
	var rolled_number = rng.randi_range(1, 4)
	var rolled_char
	var Rotation
	
	if rolled_number == 1:
		rolled_char = 'u'
		Rotation = PI
	elif rolled_number == 2:
		rolled_char = 'b'
		Rotation = 0
	elif rolled_number == 3:
		rolled_char = 'r'
		Rotation = 3*PI/2
	else:
		rolled_char = 'l'
		Rotation = PI/2
		
	if playAlive:
		play.ground = rolled_char
		play.set_global_rotation(Rotation)
		
	if play2Alive:
		play2.ground = rolled_char
		play2.set_global_rotation(Rotation)
		