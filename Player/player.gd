extends CharacterBody2D

#Player movement
var move_speed : float = 150
var jump_force : float = 175
var jump_double : float = 150
var has_double_jump : bool = true
var gravity : float = 500
var direction : Vector2 = Vector2.ZERO

#Player stats
var max_health : int = 10
@onready var health = max_health
signal health_updated(health)

func _physics_process(delta):
	#Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jump = true
	
	#Left / Right movement
	velocity.x = 0
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity.x = direction.x * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	move_and_slide()

	#Jumping
	if Input.is_action_just_pressed("move_up"):
		if is_on_floor():
			#single/initial jump
			velocity.y -= jump_force
		elif has_double_jump:
			#double jump
			velocity.y -= jump_double
			has_double_jump = false
	update_facing_direction()

	if Input.is_action_just_pressed("attack"):
		pass

func damage(amount):
	_set_health(health - amount)

func _set_health(value):
	var prev_health = health
	health = clamp (value, 0, max_health)
	if health != prev_health:
		$CanvasLayer/HealthBar.value = health
		if health == 0:
			game_over()

func game_over():
	get_tree().reload_current_scene()

func update_facing_direction ():
	if direction.x > 0:
		$Sprite.flip_h = false
	elif direction.x < 0:
		$Sprite.flip_h = true
