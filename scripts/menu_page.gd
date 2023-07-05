extends Control

# Goes to introduction page
func start_game():
	get_tree().quit()

# Goes to the options page
func options_page():
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")

# Goes to the credits page
func credits_page():
	get_tree().quit()
	
# Closes the game
func exit_game():
	get_tree().quit()

