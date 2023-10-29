extends Area2D

@export var input_letter: String = "A"
@onready var path_left: String = "res://Assets/Sprites/Characters/keycaps/keycap_" + input_letter + "_left.png"
@onready var path_right: String = "res://Assets/Sprites/Characters/keycaps/keycap_" + input_letter + "_right.png"
@onready var keycap_left = load(path_left)
@onready var keycap_right = load(path_right)

@export var move_speed : float = 25
@export var move_dir : Vector2

var start_pos : Vector2
var target_pos : Vector2

func _ready():

	start_pos = global_position
	target_pos = start_pos + move_dir
	print(path_left)
	print(path_right)
	
	if target_pos.x < start_pos.x:
		$KeycapBaseSingle.set_texture(keycap_left)
	else:
		$KeycapBaseSingle.set_texture(keycap_right)

func _process(delta):
	global_position = global_position.move_toward(target_pos, move_speed * delta)
	
	if global_position == target_pos:
		if global_position == start_pos:
			target_pos = start_pos + move_dir
			$KeycapBaseSingle.set_texture(keycap_left)
		else: 
			target_pos = start_pos
			$KeycapBaseSingle.set_texture(keycap_right)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.game_over()
