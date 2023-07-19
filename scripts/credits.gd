extends Control

func _ready():
	if(Global.music_volume != 0):
		$music.play(Global.music_part)
		$music.volume_db = Global.music_volume/2 - 35

func _process(delta):
	if($music.get_playback_position() >= 25):
		Global.music_part = 0.0
		$music.play(Global.music_part)

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("enter"):
			Global.music_part = $music.get_playback_position()
			Global.change_scene("res://scenes/menu_page.tscn")
