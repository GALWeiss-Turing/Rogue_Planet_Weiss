extends Node

var building_placeholder: Node2D = null
var placing: bool = false

func prepare_building(code: String):
	var model = load("res://%s.tscn" % code).instantiate()
	get_parent().add_child(model)
	if model.has_method("set_modulate"):
		model.modulate.a = 0.5
	building_placeholder = model
	placing = true

func _process(delta: float) -> void:
	if building_placeholder:
		building_placeholder.global_position = get_viewport().get_mouse_position()

func _unhandled_input(event: InputEvent) -> void:
	if not placing:
		return

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			place_building()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			cancel_building()

func place_building():
	if building_placeholder:
		building_placeholder.modulate.a = 1.0
		if "placed" in building_placeholder:
			building_placeholder.placed = true
		building_placeholder = null
		placing = false

func cancel_building():
	if building_placeholder:
		building_placeholder.queue_free()
		building_placeholder = null
	placing = false
