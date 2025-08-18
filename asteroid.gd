extends StaticBody2D

@onready var asteroid_rotation = randf_range(-0.05, 0.05)

func _physics_process(delta):
	rotate(asteroid_rotation * delta)
