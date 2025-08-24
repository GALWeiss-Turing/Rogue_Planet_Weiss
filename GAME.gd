extends Node2D

@export var turret_scene: PackedScene = preload("res://needler_turret.tscn")

func spawn_mob():
	var new_mob = preload("res://enemies/pirate_corvette.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func spawn_cruiser():
	var new_cruiser = preload("res://enemies/pirate_cruiser.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_cruiser.global_position = %PathFollow2D.global_position
	add_child(new_cruiser)
	
func _on_timer_mob_timeout():
	spawn_mob()

func _on_timer_cruiser_timeout():
	spawn_cruiser()
