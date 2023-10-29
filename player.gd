extends CharacterBody2D

var score : int = 0
@onready var score_text : Label = get_node("CanvasLayer/ScoreText")

var move_speed : float = 150
var jump_force : float = 175
var jump_double : float = 125
var has_double_jump : bool = true
var gravity : float = 500

func _physics_process(delta):
	#Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jump = true
	
	#Left / Right movement
	velocity.x = 0
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	
	#Jumping
	if Input.is_action_just_pressed("move_up"):
		if is_on_floor():
			#single/initial jump
			velocity.y -= jump_force
		elif has_double_jump:
			#double jump
			velocity.y -= jump_double
			has_double_jump = false
		
	move_and_slide()

func game_over ():
	get_tree().reload_current_scene()
	
func add_score (amount):
	score += amount
	score_text.text = str("Score: ", score)
