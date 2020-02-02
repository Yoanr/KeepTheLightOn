extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_emit_then_die()

func _emit_then_die():
	set_emitting(true)
	yield(get_tree().create_timer(1), "timeout")
	queue_free()
