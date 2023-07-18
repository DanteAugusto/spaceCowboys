extends Control

func _ready():
	if(Global.music_volume != 0):
		$music.play(Global.music_part)
		$music.volume_db = Global.music_volume - 20

func _process(delta):
	if($music.get_playback_position() >= 25):
		Global.music_part = 0.0
		$music.play(Global.music_part)

func adjust_volume(volume):
	$panel/VBoxContainer/curr_volume.text = str(volume)
	
	if(volume == 0):
		$music.stop()
	
	Global.music_volume = volume
	$music.volume_db = Global.music_volume - 20
	

func _input(event):
	if event is InputEvent:
		if event.is_action_pressed("Up"):
			$panel/VBoxContainer/HSlider.value += 1;
		elif  event.is_action_pressed("Down"):
			$panel/VBoxContainer/HSlider.value -= 1;
		elif event.is_action_pressed("enter"):
			Global.music_part = $music.get_playback_position()
			Global.change_scene("res://scenes/menu_page.tscn")
	


