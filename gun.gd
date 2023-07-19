extends Node2D

@onready var controls = Input.get_connected_joypads()
@onready var control = -1
@onready var sprite := $Sprite2D
@onready var gun := $Sprite2D/lock
@onready var ammoVisual := $Sprite2D/ammo

var inverted = false

var MAX_AMMO = 6
var RELOAD_TIME = 1
var bullet_speed = 4000
var bullet = preload("res://bullet.tscn")
var ammo = MAX_AMMO
var reloading = false

func _ready():
	if controls.size() >= 1:
		control = controls[0]
	ammoVisual.set_animation("default")
		

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
		if angle < -PI/2 || angle > PI/2:
			inverted = true
			gun.set_position(Vector2(24, 10.638))
			ammoVisual.set_position(Vector2(7.539, 13.692))
		else:
			inverted = false
			gun.set_position(Vector2(24, -8))
			ammoVisual.set_position(Vector2(7.539, -17.926))
		sprite.set_flip_v(inverted)
			
	if Input.is_action_just_pressed("reload") :
		if control != -1 && Input.is_joy_button_pressed(control, 10) && !reloading && ammo < MAX_AMMO:
			reload()

func fire():
	ammo -= 1
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = gun.global_position
	bullet_instance.rotation = rotation + (PI/2)
	get_tree().get_root().call_deferred("add_child",bullet_instance)
	if ammo == 5:
		ammoVisual.play("five")
	elif ammo == 4:
		ammoVisual.play("four")
	elif ammo == 3:
		ammoVisual.play("three")
	elif ammoVisual.get_animation() == "three":
		ammoVisual.set_animation("two")
	elif ammoVisual.get_animation() == "two":
		ammoVisual.set_animation("one")
	elif ammoVisual.get_animation() == "one":
		ammoVisual.set_animation("zero")
func reload():
	if !reloading:
		reloading = true
		ammoVisual.set_animation("reload")
		await get_tree().create_timer(RELOAD_TIME).timeout
		ammoVisual.set_animation("default")
		ammo = MAX_AMMO
		reloading = false
