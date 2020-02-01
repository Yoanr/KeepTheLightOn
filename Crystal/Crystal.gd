extends RigidBody2D

enum CrystalState{
	inactive,
	active
}

# Member variables here
var _state = CrystalState.inactive

# Called when the node enters the scene tree for the first time.
func _ready():
	setState(CrystalState.inactive)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _state == CrystalState.active and linear_velocity == Vector2.ZERO:
		setState(CrystalState.inactive)
	pass

func take():
	setState(CrystalState.active)
	pass

func throw(force, direction):
	var impulse = force * direction
	apply_central_impulse(impulse)
	pass

func setState(newState):
	if newState == CrystalState.active :
		_state = CrystalState.active
		# change sprite here
		
	if newState == CrystalState.inactive :
		_state = CrystalState.inactive
		# change sprite here


