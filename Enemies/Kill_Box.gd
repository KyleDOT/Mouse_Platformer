extends Area2D

var trap_damage = 10

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.damage(trap_damage)
