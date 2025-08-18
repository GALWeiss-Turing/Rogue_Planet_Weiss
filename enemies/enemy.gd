extends CharacterBody2D
class_name Enemy

@onready var base = get_node('/root/Game/main_base')

@export var MAX_HEALTH := 200.0
@export var explosion_damage := 20.0
@export var detection_signature := 1.0

var health: float
var speed := 100.0
var aggro_target: Node2D = null

func _ready():
	health = MAX_HEALTH
	add_to_group("enemies")

func _physics_process(delta):
	var target_pos: Vector2
	if aggro_target and is_instance_valid(aggro_target):
		target_pos = aggro_target.global_position
	else:
		target_pos = base.global_position
		aggro_target = null

	# Calculate movement
	var direction = global_position.direction_to(target_pos)
	velocity = direction * speed
	look_at(target_pos)

	# Move and check collision
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		explode(collision_info.get_collider())

func damage(attack: Attack):
	health -= attack.attack_damage
	if health <= 0:
		explode()

func explode(target: Node = null):
	$Death_explosion.emitting = true

	if target and target.has_method("take_damage"):
		target.take_damage(explosion_damage)

	$Timer.start()

func _on_timer_timeout():
	queue_free()
