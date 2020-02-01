extends RigidBody2D
onready var utils = preload("res://Utils/Color.gd").new()

enum CrystalState{
	inactive,
	active
}

# Member variables here
var _color
var _state = CrystalState.inactive


# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize
	setState(CrystalState.inactive)
	
	# Test
	throw(800, Vector2(-2,2))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _state == CrystalState.active and linear_velocity == Vector2.ZERO:
		setState(CrystalState.inactive)
	pass

func take():
	setState(CrystalState.active)
	pass

# Takes a force (float) and direction (Vector2, normalized or not)
func throw(force, direction):
	var impulse = force * direction.normalized()
	apply_central_impulse(impulse)
	pass

func setState(newState):
	if newState == CrystalState.active :
		_state = CrystalState.active
		# change sprite here
		
	if newState == CrystalState.inactive :
		_state = CrystalState.inactive
		# change sprite here

# Takes a color from utils ColorEnum 
func setColor(newColor):
	# sets internal color value
	_color = newColor
	# get the matching color from the utils file and sets sprite color
	$AnimatedSprite.modulate = utils.getColorValue(newColor)

func isActive():
	return _state == CrystalState.active;
