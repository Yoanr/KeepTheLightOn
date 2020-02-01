extends RigidBody2D
onready var utils = preload("res://Utils/Color.gd").new()

enum CrystalState{
	inactive,
	active
}

enum OwnedState{
	not_owned,
	owned
}
	

# Member variables here
var _color
var _state = CrystalState.inactive
var owned_state = OwnedState.not_owned

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("crystal")
	# Initialize
	_setState(CrystalState.inactive)
	setColor(utils.ColorEnum.WHITE)
	pass # Replace with function body.

# Called every frame
func _process(_delta):
	if _state == CrystalState.active and linear_velocity == Vector2.ZERO:
		_setState(CrystalState.inactive)
	pass

func take():
	_setState(CrystalState.active)
	owned_state = OwnedState.owned
	pass

# Takes a force (float) and direction (Vector2, normalized or not)
func throw(force, direction):
	var impulse = force * direction.normalized()
	apply_central_impulse(impulse)
	owned_state = OwnedState.not_owned
	pass

# Change crystal state
func _setState(newState):
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
