extends Control

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("enter"):
			Global.change_scene("res://scenes/menu_page.tscn")
