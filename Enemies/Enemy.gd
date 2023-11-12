extends Area2D

#Defining keycap letter & loading relevant files
@export var input_letter: String = "A"
@onready var path_left: String = "res://Assets/Sprites/Characters/keycaps/keycap_" + input_letter + "_left.png"
@onready var path_right: String = "res://Assets/Sprites/Characters/keycaps/keycap_" + input_letter + "_right.png"
@onready var path_audio: String = "res://Assets/DeathAudio/" + input_letter + ".mp3"
@onready var keycap_left = load(path_left)
@onready var keycap_right = load(path_right)
@onready var death_audio = load(path_audio)

@export var HP_Vis : bool = true
@export var Bullet : PackedScene

#Enemy stats
@export var move_speed : float = 25
@export var move_dir : Vector2
var melee_damage : int = 2
var shoot_damage : int = 1
var max_health : int = 3
@onready var health = max_health

#Enemy patrol
var start_pos : Vector2
var target_pos : Vector2

func _ready():
	start_pos = global_position
	target_pos = start_pos + move_dir
	
	#Initial facing
	if target_pos.x < start_pos.x:
		$KeycapBaseSingle.set_texture(keycap_left)
		$RayCast2D.position.x = -20
		$RayCast2D.target_position.x = -300
		$RayCast2D/Marker2D.rotation_degrees = 180
	else:
		$KeycapBaseSingle.set_texture(keycap_right)
		$RayCast2D.position.x = 20
		$RayCast2D.target_position.x = 300
		$RayCast2D/Marker2D.rotation_degrees = 0
	
	#HealthBar visible
	if HP_Vis == false:
		$KeycapBar.visible = false

func _process(delta):
	global_position = global_position.move_toward(target_pos, move_speed * delta)
	
	if global_position == target_pos:
		if global_position == start_pos:
			target_pos = start_pos + move_dir
			$KeycapBaseSingle.set_texture(keycap_left)
			$RayCast2D.position.x = -20
			$RayCast2D.target_position.x = -300
			$RayCast2D/Marker2D.rotation_degrees = 180
		else: 
			target_pos = start_pos
			$KeycapBaseSingle.set_texture(keycap_right)
			$RayCast2D.position.x = 20
			$RayCast2D.target_position.x = 300
			$RayCast2D/Marker2D.rotation_degrees = 0
			
	if $RayCast2D.is_colliding() and $Timer.is_stopped():
		shoot()

func shoot():
	print("Shot fired")
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.transform = $RayCast2D/Marker2D.global_transform
	$Timer.start()

#Deal damage
func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.damage(melee_damage)

#Take damage
func damage(amount):
	_set_health(health - amount)

func _set_health(value):
	var prev_health = health
	health = clamp (value, 0, max_health)
	if health != prev_health:
		$KeycapBar.value = health
		if health == 0:
			killed()

func killed():
	$DeathAudio.stream = death_audio
	$DeathAudio.play()

func _on_death_audio_finished():
	queue_free()
