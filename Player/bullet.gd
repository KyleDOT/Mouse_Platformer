extends Area2D

var bullet_speed = 500
var bullet_damage : int = 1

func _process(delta):
	position += transform.x * bullet_speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.damage(bullet_damage)
	elif !body.is_in_group("Player"):
		queue_free()

#func set_gun_rock():
#	$GunSpritevar.texture = "res://Assets/Sprites/Objects/rock_roll.png"
#	var fire_rate = 3
#	var damage = 1
#
#func set_gun_hand():
#	$GunSpritevar.texture = "res://Assets/Sprites/Objects/finger_gun.png"
#	var fire_rate = 2
#	var damage = 1.5
#
#func set_gun_hour():
#	$GunSpritevar.texture = "res://Assets/Sprites/Objects/hourglass_50.png"
#	var fire_rate = 1
#	var damage = 3
