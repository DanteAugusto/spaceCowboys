extends Control

# Goes to introduction page
func start_game():
	Global.change_scene("res://scenes/selection_menu.tscn")

# Goes to the options page
func options_page():
	Global.change_scene("res://scenes/options_menu.tscn")

# Goes to the credits page
func credits_page():
	Global.change_scene("res://scenes/credits.tscn")
	
# Closes the game
func exit_game():
	get_tree().quit()

