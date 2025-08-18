extends Area2D

var travelled_distance = 0
var shooter: Shooter = null
var attack: Attack

func _physics_process(delta):
	const SPEED = 1000
	const RANGE = 1500
	var direction = Vector2.UP.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body):
	if body.has_method("damage"):
		var attack = Attack.new()
		attack.attack_damage = 10
		attack.pierce = 1
		body.damage(attack)
	queue_free()
