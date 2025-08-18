extends Enemy
class_name Cruiser

func _ready():
	super._ready()
	MAX_HEALTH = 300
	detection_signature = 2.0
