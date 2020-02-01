extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var _direction
var _generatorPosition
var _randomGen
export (float) var speed = 5
export (float) var deviationRatio = 0.2 # between 0 and 1

# Called when the node enters the scene tree for the first time.
func _ready():
	_randomGen = RandomNumberGenerator.new()
	connect("body_entered",self,"onBodyEntered")
	# Test
	_direction = Vector2(2,0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	linear_velocity = _direction * speed * delta
	pass

func _follow():
	_direction = _generatorPosition - position
	_direction += .randf_range(-deviationRatio,deviationRatio)
	pass

func onBodyEntered(body):
	if(body.is_in_group("crystal")):
		var crystal = body
		if crystal.isACtive():
			_die()
			
	if(body.is_in_group("player")):
		var player = body
		# todo
		# player.disable()


func _die():
	#fx
	#remove from scene
	get_parent().remove_child(self)
	pass
