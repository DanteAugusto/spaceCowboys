extends Node
# "Classe" que armazena variáveis globais do jogo

var gameWinner = 0
var roundsPlayer1 = 0 # Quantidade de rounds vencidos player 1
var roundsPlayer2 = 0 # Quantidade de rounds vencidos player 2
# var player1Dir = "res://jogo_oficial/Players/boy1.tscn" # Animação player 1
# var player2Dir = "res://jogo_oficial/Players/girl1.tscn" # Animaçõa player 2

# Reseta os pontos dos dois players
func reset_scores():
	roundsPlayer1 = 0
	roundsPlayer2 = 0
	gameWinner = 0

func update_score(winner):
	if winner == 1:
		roundsPlayer1 += 1
	else:
		roundsPlayer2 += 1

# Troca para a cena informada
func change_scene(cena):
	# Carregar a nova cena
	get_tree().change_scene_to_file(cena)

# Troca para um novo mapa onde os jogadores irão duelar, ou para a cena final de vitória
func change_map():
	if gameWinner != 0:
		gameWinner = 0 # Tirar depois
		# TODO: Mudar para a cena final de vitória
		#change_scene(cena)
	else:
		gameWinner = 1 # Tirar depois
		# TODO: Mudar para um mapa que os jogadores ainda não visitaram
		#change_scene(mapa)
