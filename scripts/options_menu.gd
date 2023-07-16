extends Control

func adjust_volume(volume):
	$panel/VBoxContainer/curr_volume.text = str(volume)

func _input(event):
	if event is InputEvent:
		if event.is_action_pressed("Up"):
			$panel/VBoxContainer/HSlider.value += 1;
		elif  event.is_action_pressed("Down"):
			$panel/VBoxContainer/HSlider.value -= 1;
		elif event.is_action_pressed("enter"):
			Global.change_scene("res://scenes/menu_page.tscn")
	


