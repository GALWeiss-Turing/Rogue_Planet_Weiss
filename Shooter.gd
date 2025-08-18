extends Area2D
class_name Shooter

@export var fire_rate := 0.6
@export var rotation_speed := 8.0
@export var detection_range := 300.0 # w pikselach

@onready var firerate_timer := $FireRate_Timer as Timer
@onready var shoot_sound := $ShootSound as AudioStreamPlayer2D

var health := 50
var target: Enemy = null

func _physics_process(delta):
	update_target()
	if target:
		var target_pos: Vector2 = target.global_position
		var target_rot: float = global_position.direction_to(target_pos).angle()
		rotation = lerp_angle(rotation, target_rot, rotation_speed * delta)


func update_target():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var closest: Enemy = null
	var closest_dist := INF

	for e in enemies:
		if not e is Enemy:
			continue
		var dist = global_position.distance_to(e.global_position)
		var effective_range = detection_range * e.detection_signature
		if dist < effective_range and dist < closest_dist:
			closest = e
			closest_dist = dist

	target = closest


func shoot():
	firerate_timer.start()
	if target:
		shoot_sound.play()
		const BULLET = preload("res://bullet.tscn")
		var new_bullet = BULLET.instantiate()
		new_bullet.shooter = self
		new_bullet.global_position = %Muzzle.global_position
		new_bullet.global_rotation = %Muzzle.global_rotation
		%Muzzle.add_child(new_bullet)


func _on_firerate_timer_timeout():
	shoot()

func take_damage(amount: float):
	health -= amount
	if health <= 0:
		queue_free() # destroy turret
