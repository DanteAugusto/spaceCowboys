extends Control

func _ready():
	$panel/VBoxContainer/HSlider.value = Global.music_volume
	$panel/VBoxContainer/curr_volume.text = str(Global.music_volume)
	
	if(Global.music_volume != 0):
		$music.play(Global.music_part)
		$music.volume_db = Global.music_volume 

func _process(delta):
	if($music.get_playback_position() >= 25):
		Global.music_part = 0.0
		$music.play(Global.music_part)

func adjust_volume(volume):
	$panel/VBoxContainer/curr_volume.text = str(volume)
	Global.music_volume = volume/10
	
	if(Global.music_volume == 0):
		Global.music_part = $music.get_playback_position()
		$music.stop()
	
	if(Global.music_volume != 0):
		$music.play(Global.music_part)
		$music.volume_db = Global.music_volume 
	

func _input(event):
	if event is InputEvent:
		if event.is_action_pressed("Up"):
			$panel/VBoxContainer/HSlider.value += 1;
		elif  event.is_action_pressed("Down"):
			$panel/VBoxContainer/HSlider.value -= 1;
		elif event.is_action_pressed("enter"):
			Global.music_part = $music.get_playback_position()
			Global.change_scene("res://scenes/menu_page.tscn")
	


