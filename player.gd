extends CharacterBody2D


@export var SPEED := 100.0
@export var JUMP_VELOCITY := -100.0

@onready var controls = Input.get_connected_joypads()
@onready var control = -1


# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity := 100
var ground = 'b'

@onready var animation : AnimatedSprite2D = null
@onready var effects = null

var MAX_HEALTH = 3
var IMMUNE_TIME = 1
var curr_player := 0
var is_jumping := false
var immune := false
var health = MAX_HEALTH
var knockback_vector := Vector2.ZERO

signal is_dead
signal took_damage


func initialize(n_player):
	curr_player = n_player
	if n_player == 0:
		animation = load(Global.player1Dir).instantiate()
	else:
		animation = load(Global.player2Dir).instantiate()
	add_child(animation)
	
	var name =animation.get_name()
	if name == "onion":
		effects = $onion/Effects
	elif name == "mr_mochi":
		effects = $mr_mochi/Effects
	elif name == "robo_pumpkin":
		effects = $robo_pumpkin/Effects
	elif name == "robo_totem":
		effects = $robo_totem/Effects
	
	if controls.size() > n_player:
		control = controls[n_player]
	
func _physics_process(delta):
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
	if control != -1 && Input.get_joy_axis(control, 4) && Input.is_action_just_pressed("ui_accept") :
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
			animation.play("jumping")
		else:
			animation.play("running")		
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
			animation.play("jumping")
		else:
			animation.play("idle")
			
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	
	move_and_slide()

func take_damage(damage := 0, knockback_force := Vector2.ZERO, duration := 0.25):
	if !immune:
		took_damage.emit()
		health -= damage
		
		if knockback_force != Vector2.ZERO:
			knockback_vector = knockback_force
			
			var knockback_tween := get_tree().create_tween()
			knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
			# animation.modulate = Color(1, 0, 0, 1)
			# knockback_tween.parallel().tween_property(animation, "modulate", Color(1,1,1,1), duration)
		
		if(health <= 0):
			
			is_dead.emit()



func _on_took_damage():
	immune = true
	effects.play("hurtBlink")
	await get_tree().create_timer(IMMUNE_TIME).timeout
	effects.play("RESET")
	immune = false



func _on_fall_notifier_screen_exited():
	take_damage(MAX_HEALTH)
