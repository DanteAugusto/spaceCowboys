extends PanelContainer

var mr_mochi = "res://players/mr_mochi.tscn"
var onion = "res://players/onion.tscn"
var robo_pumpkin = "res://players/robo_pumpkin.tscn"
var robo_totem = "res://players/robo_totem.tscn"

@onready var player1 = mr_mochi
@onready var player2 = robo_totem

var p1_selected
var p2_selected
var p_ready = 0

signal p1_ready
signal p2_ready

func _input(event):
	if event is InputEventKey:
		if p1_selected == null:
			if event.is_action_pressed("a") && is_avaiable(mr_mochi):
				clear_p1()
				select($mrmochi/p1)
				player1 = mr_mochi
			elif event.is_action_pressed("s") && is_avaiable(onion):
				clear_p1()
				select($onion/p1)
				player1 = onion
			elif event.is_action_pressed("d") && is_avaiable(robo_pumpkin):
				clear_p1()
				select($robo_pumpkin/p1)
				player1 = robo_pumpkin
			elif event.is_action_pressed("f") && is_avaiable(robo_totem):
				clear_p1()
				select($robo_totem/p1)
				player1 = robo_totem
			elif event.is_action_pressed("ui_accept2"):
				p1_selected = player1 
				p1_ready.emit()
		
		if p2_selected == null:
			if event.is_action_pressed("h") && is_avaiable(mr_mochi):
				clear_p2()
				select($mrmochi/p2)
				player2 = mr_mochi
			elif event.is_action_pressed("j") && is_avaiable(onion):
				clear_p2()
				select($onion/p2)
				player2 = onion
			elif event.is_action_pressed("k") && is_avaiable(robo_pumpkin):
				clear_p2()
				select($robo_pumpkin/p2)
				player2 = robo_pumpkin
			elif event.is_action_pressed("l") && is_avaiable(robo_totem):
				clear_p2()
				select($robo_totem/p2)
				player2 = robo_totem
			elif event.is_action_pressed("enter"):
				p2_selected = player2
				p2_ready.emit()

func clear_p1():
	$mrmochi/p1.visible = false
	$onion/p1.visible = false
	$robo_pumpkin/p1.visible = false
	$robo_totem/p1.visible = false

func clear_p2():
	$mrmochi/p2.visible = false
	$onion/p2.visible = false
	$robo_pumpkin/p2.visible = false
	$robo_totem/p2.visible = false
	
func select(player):
	player.move_to_front()
	player.visible = true
	
func is_avaiable(player):
	return !(player == p1_selected || player == p2_selected)
	

func go_to_next_scene():
	p_ready += 1
	
	if(p_ready >= 2): 
		Global.player1Dir = p1_selected
		Global.player2Dir = p2_selected
		print(Global.player1Dir)
		print(Global.player2Dir)
		Global.change_scene("res://scenes/menu_page.tscn")
		
