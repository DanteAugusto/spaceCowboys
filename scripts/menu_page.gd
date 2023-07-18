extends Control

func _ready():
	if(Global.music_volume != 0):
		$music.play(Global.music_part)
		$music.volume_db = Global.music_volume - 20

func _process(delta):
	if($music.get_playback_position() >= 25):
		Global.music_part = 0.0
		$music.play(Global.music_part)
	

# Goes to introduction page
func start_game():
	Global.music_part = $music.get_playback_position()
	Global.change_scene("res://scenes/selection_menu.tscn")

# Goes to the options page
func options_page():
	Global.music_part = $music.get_playback_position()
	Global.change_scene("res://scenes/options_menu.tscn")

# Goes to the credits page
func credits_page():
	Global.music_part = $music.get_playback_position()
	Global.change_scene("res://scenes/credits.tscn")
	
# Closes the game
func exit_game():
	get_tree().quit()

