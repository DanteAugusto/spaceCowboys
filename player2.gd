extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var controls = Input.get_connected_joypads()
@onready var control = -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1000
var ground = 'b'
@onready var animation := $anim as AnimatedSprite2D

var is_jumping := false



func _ready():
	if controls.size() > 1:
		control = controls[1]
func _physics_process(delta):
	if Input.is_key_pressed(KEY_U):
		ground = 'u'
		set_global_rotation(PI)
		#print("para cima")
	if Input.is_key_pressed(KEY_L):
		ground = 'l'
		set_global_rotation(PI/2)
		#print("para esquerda")
	if Input.is_key_pressed(KEY_B):
		ground = 'b'
		set_global_rotation(0)
		#print("para baixo")
	if Input.is_key_pressed(KEY_R):
		ground = 'r'
		set_global_rotation(3*PI/2)
		#print("para direita")
	# Add the gravity.
	#if not is_on_floor():
	if ground == 'u':
		velocity.y -= gravity * delta
	if ground == 'l':
		velocity.x -= gravity * delta
	if ground == 'b':
		#animation.scale.y = 1
		velocity.y += gravity * delta
	if ground == 'r':
		velocity.x += gravity * delta
	# Handle Jump.
	if control != -1 && Input.get_joy_axis(control, 5) && Input.is_action_just_pressed("ui_accept") :
		if ground == 'b' and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if ground == 'u' and is_on_ceiling():
			velocity.y = (-1)*JUMP_VELOCITY
		if ground == 'r' and is_on_wall():
			velocity.x = JUMP_VELOCITY
		if ground == 'l' and is_on_wall():
			velocity.x = (-1)*JUMP_VELOCITY
		is_jumping = true
	else:
		if ground == 'b' and is_on_floor():
			is_jumping = false
		if ground == 'u' and is_on_ceiling():
			is_jumping = false
		if ground == 'l' and is_on_wall():
			is_jumping = false
		if ground == 'r' and is_on_wall():
			is_jumping = false
	
	#rotacionar
	#var batata = Vector2(Input.get_joy_axis(control, JOY_AXIS_RIGHT_X), Input.get_joy_axis(control, JOY_AXIS_RIGHT_Y))
	#var angle = batata.angle()
	#rotation = angle
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = 0
	if control != -1:
		direction = Input.get_joy_axis(control, 0)
	#margem de erro porque se não o boneco anda sozinho
	#if direction != 0:
	if direction >= 0.05 || direction <= -0.05:
		#print("controle número ", control)
		#print(direction)
		if ground == 'l':
			velocity.y = direction * SPEED
		elif ground == 'r':
			velocity.y = (-1)*direction * SPEED
		else:
			velocity.x = direction * SPEED
		if is_jumping == true:
			animation.play("jump")
		else:
			animation.play("run")		
		if ground == 'u':
			if direction > 0:
				animation.scale.x = -1
			else:
				animation.scale.x = 1
		else:
			if direction > 0:
				animation.scale.x = 1
			else:
				animation.scale.x = -1
	else:
		if ground == 'l' || ground == 'r':
			velocity.y = move_toward(velocity.y, 0, SPEED)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_jumping == true:
			animation.play("jump")
		else:
			animation.play("idle")
	move_and_slide()