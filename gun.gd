extends Node2D

@onready var controls = Input.get_connected_joypads()
@onready var control = -1
@onready var gun := $lock


var bullet_speed = 4000
var bullet = preload("res://bullet.tscn")

func _ready():
	if controls.size() > 1:
		control = controls[0]
		

func _process(delta):
	if Input.is_action_just_pressed("shoot") :
		if control != -1 && Input.is_joy_button_pressed(control,10):
			fire()
	var batata = Vector2(Input.get_joy_axis(control, JOY_AXIS_RIGHT_X), Input.get_joy_axis(control, JOY_AXIS_RIGHT_Y))
	var angle = batata.angle()
	if(batata[0] >= 0.2 || batata[0] <= -0.2 || batata[1] >= 0.2 || batata[1] <= -0.2):
		rotation = angle

func fire():
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = gun.global_position
	bullet_instance.rotation = rotation + (PI/2)
	get_tree().get_root().call_deferred("add_child",bullet_instance)
