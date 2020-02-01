extends Node2D
onready var utilsColor = preload("res://Utils/Color.gd").new()

var _colorRequired
var _state
var _elapsedTime = 0.0

enum _State {FUNCTIONNAL, BROKEN, DESTROYED}

export (float) var changeStateTime = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("battery")
	connect("body_entered",self,"_onBodyEntered")
	_colorRequired = utilsColor.randomColor()
	_state = _State.FUNCTIONNAL

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_elapsedTime += delta
	print("_elapsedTime: ",_elapsedTime)
	_manageState()
	print("state: ",_state)

func _manageState():
	if(_elapsedTime >= changeStateTime):
		if(_state != _State.DESTROYED):
			_elapsedTime = 0.0
			_state = _state + 1

func _onBodyEntered(body):
	pass

# Getter and Setter 
func getColorRequired() -> int:
	return _colorRequired

func setColorRequired(colorGiven):
	_colorRequired = colorGiven

func getState() -> int:
	return _state

func setState(stateGiven):
	_state = stateGiven
