extends PanelContainer

var mr_mochi = "res://players/mr_mochi.tscn"
var onion = "res://players/onion.tscn"
var robo_pumpkin = "res://players/robo_pumpkin.tscn"
var robo_totem = "res://players/robo_totem.tscn"

@onready var player1 = mr_mochi
@onready var player2 = robo_totem
@onready var controls = Input.get_connected_joypads()
@onready var control1 = -1
@onready var control2 = -1

var p1_selected
var p2_selected
var p_ready = 0

signal p1_ready
signal p2_ready

func _ready():
	if controls.size() > 0:
		control1 = controls[0]
	if controls.size() > 1:
		control2 = controls[1]
	if(Global.music_volume != 0):
		$"../music".play(Global.music_part)
		$"../music".volume_db = Global.music_volume/2 - 35

func _process(delta):
	if($"../music".get_playback_position() >= 25):
		Global.music_part = 0.0
		$"../music".play(Global.music_part)

func _input(event):
	if event is InputEventJoypadButton:
		if p1_selected == null:
			if event.is_action_pressed("right") && Input.is_joy_button_pressed(control1,14):
				if player1 != robo_totem:
					clear_p1()
				if player1 == mr_mochi:
					if is_avaiable(onion):
						select($onion/p1)
						player1 = onion
					else:
						select($robo_pumpkin/p1)
						player1 = robo_pumpkin
				elif player1 == onion:
					clear_p1()
					if is_avaiable(robo_pumpkin):
						select($robo_pumpkin/p1)
						player1 = robo_pumpkin
					else:
						select($robo_totem/p1)
						player1 = robo_totem
				elif player1 == robo_pumpkin:
					if is_avaiable(robo_totem):
						clear_p1()
						select($robo_totem/p1)
						player1 = robo_totem
			elif event.is_action_pressed("left") && Input.is_joy_button_pressed(control1,13):
				if player1 != mr_mochi:
					clear_p1()
				if player1 == robo_totem:
					if is_avaiable(robo_pumpkin):
						select($robo_pumpkin/p1)
						player1 = robo_pumpkin
					else:
						select($onion/p1)
						player1 = onion
				elif player1 == robo_pumpkin:
					if is_avaiable(onion):
						select($onion/p1)
						player1 = onion
					else:
						select($mrmochi/p1)
						player1 = mr_mochi
				elif player1 == onion:
					if is_avaiable(mr_mochi):
						select($mrmochi/p1)
						player1 = mr_mochi
			elif event.is_action_pressed("accept") && Input.is_joy_button_pressed(control1,0):
				p1_selected = player1 
				p1_ready.emit()	
		if p2_selected == null:
			if event.is_action_pressed("right") && Input.is_joy_button_pressed(control2,14):
				if player2 != robo_totem:
					clear_p2()
				if player2 == mr_mochi:
					if is_avaiable(onion):
						select($onion/p2)
						player2 = onion
					else:
						select($robo_pumpkin/p2)
						player2 = robo_pumpkin
				elif player2 == onion:
					clear_p2()
					if is_avaiable(robo_pumpkin):
						select($robo_pumpkin/p2)
						player2 = robo_pumpkin
					else:
						select($robo_totem/p2)
						player2 = robo_totem
				elif player2 == robo_pumpkin:
					if is_avaiable(robo_totem):
						clear_p2()
						select($robo_totem/p2)
						player2 = robo_totem
			elif event.is_action_pressed("left") && Input.is_joy_button_pressed(control2,13):
				if player2 != mr_mochi:
					clear_p2()
				if player2 == robo_totem:
					if is_avaiable(robo_pumpkin):
						select($robo_pumpkin/p2)
						player2 = robo_pumpkin
					else:
						select($onion/p2)
						player2 = onion
				elif player2 == robo_pumpkin:
					if is_avaiable(onion):
						select($onion/p2)
						player2 = onion
					else:
						select($mrmochi/p2)
						player2 = mr_mochi
				elif player2 == onion:
					if is_avaiable(mr_mochi):
						select($mrmochi/p2)
						player2 = mr_mochi
			elif event.is_action_pressed("accept") && Input.is_joy_button_pressed(control2,0):
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
		Global.begin_play()
		
