extends CharacterBody2D

func _physics_process(delta):
	rotate(0.005)

var health := 100

func take_damage(amount: float):
	health -= amount
	print("Oy Vey", health)
	if health <= 0:
		print("The West has Fallen")
