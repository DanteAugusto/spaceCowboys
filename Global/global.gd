extends Node
# "Classe" que armazena variáveis globais do jogo

var roundsPlayer1 = 0 # Quantidade de rounds vencidos player 1
var roundsPlayer2 = 0 # Quantidade de rounds vencidos player 2
# var player1Dir = "res://jogo_oficial/Players/boy1.tscn" # Animação player 1
# var player2Dir = "res://jogo_oficial/Players/girl1.tscn" # Animaçõa player 2

# Reseta os pontos dos dois players
func reset_scores():
	roundsPlayer1 = 0
	roundsPlayer2 = 0

# Troca para a cena informada
func trocar_cena(cena):
	# Carregar a nova cena
	get_tree().change_scene_to_file(cena)
