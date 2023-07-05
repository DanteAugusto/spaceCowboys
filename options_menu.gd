extends Control


func go_back():
	get_tree().change_scene_to_file("res://scenes/menu_page.tscn")

func adjust_volume(volume):
	$panel/VBoxContainer/curr_volume.text = str(volume)

func _input(event):
	if event is InputEvent:
		if event.is_action_pressed("Up"):
			$panel/VBoxContainer/HSlider.value += 1;
		elif  event.is_action_pressed("Down"):
			$panel/VBoxContainer/HSlider.value -= 1;
	


