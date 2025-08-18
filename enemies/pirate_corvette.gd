extends Enemy
class_name Corvette

func _ready():
	super._ready()
	MAX_HEALTH = 70
	detection_signature = 0.8
