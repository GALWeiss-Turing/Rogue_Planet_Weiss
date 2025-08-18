extends Node2D

@export var turret_scene: PackedScene = preload("res://needler_turret.tscn")

func _input(event):
	if event.is_action_pressed("click"):
		var new_turret = turret_scene.instantiate()
		var mouse_pos = get_viewport().get_mouse_position()
		new_turret.position = get_global_mouse_position()
		add_child(new_turret)

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
