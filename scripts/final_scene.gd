extends Node2D

@onready var music := $music
@onready var gun := $Guns/gun
@onready var gun2 := $Guns/gun2
@onready var button := $restart
@onready var play := $Players/player
@onready var play2 := $Players/player2

# Called when the node enters the scene tree for the first time.
func _ready():
	gun.visible = false
	gun2.visible = false
	button.visible = false
	play.initialize(0)
	play2.initialize(1)
	if(Global.music_volume != 0):
		music.play(Global.music_part)
		music.volume_db = Global.music_volume/2 - 35
	winner()
	set_process_input(false)
	gun.set_process_input(false)
	gun2.set_process_input(false)
	
func _process(delta):
	gun.global_position = play.global_position
	gun2.global_position = play2.global_position
	if(music.get_playback_position() > 56 && Global.music_volume != 0):
		Global.battle_part = 32
		music.play(Global.battle_part)

func winner():
	await get_tree().create_timer(5).timeout
	play.set_process_input(false)
	play2.set_process_input(false)
	play.position = Vector2(232, 232)
	play2.position = Vector2(456, 232)
	var res = "Congrats player " + str(Global.gameWinner) + "!!!\n You are the SpaceCowboy :)"
	
	if(Global.gameWinner == 1):
		gun.visible = true
	elif(Global.gameWinner == 2):
		gun2.visible = true
	else:
		res = "Congrats players!!!\n You're both SpaceCowboys :)"
		
	var lenght = res.length()
	for i in range(lenght):
		$result.text += res[i]
		await get_tree().create_timer(0.1).timeout
	
	button.visible = true
	set_process_input(true)

func _input(event):
	if event is InputEvent:
		if event.is_action_pressed("enter"):
			Global.music_part = $music.get_playback_position()
			Global.reset_scores()
			Global.change_scene("res://scenes/menu_page.tscn")
