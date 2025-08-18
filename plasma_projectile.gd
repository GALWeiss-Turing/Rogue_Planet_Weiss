extends Area2D

var travelled_distance = 0

func _physics_process(delta):
	const SPEED = 700
	const RANGE = 1900
	var direction = Vector2.UP.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

func explode():
	get_node("CPUParticles2D").emitting = true


func _on_body_entered(body):
	%hitbox.set_disabled(false)
		
	if body.has_method("damage"):
		
		var attack = Attack.new()
		attack.attack_damage = 20
		attack.pierce = 1
		body.damage(attack)
		explode()
		$Timer.start()
	
	



func _on_timer_timeout():
	queue_free()
