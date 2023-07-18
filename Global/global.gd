extends Node
# "Classe" que armazena variáveis globais do jogo

var ROUNDS_NEEDED_TO_WIN = 3
var gameWinner = 0
var roundsPlayer1 = 0 # Quantidade de rounds vencidos player 1
var roundsPlayer2 = 0 # Quantidade de rounds vencidos player 2
var player1Dir # Animação player 1
var player2Dir # Animaçõa player 2
var dirLevels = [] # Vetor com os caminhos para os levels
var qntLevels = 2 # Quantidade de levels existentes
var currMap = 0
var music_part = 0.0 
var music_volume = 1
var battle_part = 32.0

# Função chamada no início de tudo
func _ready():
	# Salva o caminho dos levels
	for i in range(qntLevels):
		dirLevels.append("res://levels/level" + str(i) + ".tscn")
		
	reset_scores()
	currMap = 0
	# begin_play() # <------- DEBUG ONLY !!!!!!!!

# Função chamada no início de um jogo (depois da seleção de players)
func begin_play():
	# Randomiza a ordem dos mapas
	dirLevels.shuffle()
	currMap = 0
	# Vai para o primeiro mapa
	change_scene(dirLevels[currMap])

# Reseta os pontos dos dois players
func reset_scores():
	roundsPlayer1 = 0
	roundsPlayer2 = 0
	gameWinner = 0

# Atualiza o score dos players, e verifica se alguém ganhou o jogo
func update_score(winner):
	if winner == 1:
		roundsPlayer1 += 1
	else:
		roundsPlayer2 += 1
	check_winner()

# Checa se temos um vencedor
func check_winner():
	if roundsPlayer1 >= ROUNDS_NEEDED_TO_WIN:
		gameWinner = 1
	elif roundsPlayer2 >= ROUNDS_NEEDED_TO_WIN:
		gameWinner = 2

# Troca para a cena informada
func change_scene(cena):
	# Carregar a nova cena
	get_tree().change_scene_to_file(cena)

# Troca para um novo mapa onde os jogadores irão duelar, ou para a cena final de vitória
func load_next_map():
	if gameWinner != 0:
		gameWinner = 0 # Tirar depois
		# TODO: Mudar para a cena final de vitória
		#change_scene(cena)
	else:
		currMap = (currMap + 1) % dirLevels.size()
		# Mudar para um mapa que os jogadores ainda não visitaram
		change_scene(dirLevels[currMap])
