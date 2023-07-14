extends Node2D

@onready var controls = Input.get_connected_joypads()
@onready var control = -1
@onready var gun := $lock

var MAX_AMMO = 6
var RELOAD_TIME = 1
var bullet_speed = 4000
var bullet = preload("res://bullet.tscn")
var ammo = MAX_AMMO
var reloading = false

func _ready():
	if controls.size() >= 1:
		control = controls[0]
		

func _process(delta):
	if Input.is_action_just_pressed("shoot") :
		if control != -1 && Input.get_joy_axis(control,5) && !reloading:
			if ammo > 0:
				fire()
			else:
				reload()
			
	var batata = Vector2(Input.get_joy_axis(control, JOY_AXIS_RIGHT_X), Input.get_joy_axis(control, JOY_AXIS_RIGHT_Y))
	var angle = batata.angle()
	if(batata[0] >= 0.2 || batata[0] <= -0.2 || batata[1] >= 0.2 || batata[1] <= -0.2):
		rotation = angle
	if Input.is_action_just_pressed("reload") :
		if control != -1 && Input.is_joy_button_pressed(control, 10) && !reloading && ammo < MAX_AMMO:
			reload()

func fire():
	ammo -= 1
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = gun.global_position
	bullet_instance.rotation = rotation + (PI/2)
	get_tree().get_root().call_deferred("add_child",bullet_instance)

func reload():
	if !reloading:
		reloading = true
		await get_tree().create_timer(RELOAD_TIME).timeout
		ammo = MAX_AMMO
		reloading = false
