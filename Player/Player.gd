extends RigidBody2D


export (int) var id_player = 1
export (float) var speed = 500
var throw_strength: int = 0
var has_crystal: bool = false
var crystal
var last_rot: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"body_entered")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Get inputs
	var id: String = "P" + String(id_player)
	var left_input: float = Input.get_action_strength(id + "_Left")
	var right_input: float = Input.get_action_strength(id + "_Right")
	var up_input: float = Input.get_action_strength(id + "_Up")
	var down_input: float = Input.get_action_strength(id + "_Down")
	var move_input: Vector2 = Vector2(right_input - left_input, down_input - up_input)
	var is_loading_throw: bool = Input.is_action_pressed(id + "_Throw")
	var is_releasing_throw:bool = Input.is_action_just_released(id + "_Throw")
	
	# Move player
	linear_velocity = move_input * speed
	rotation = last_rot
	if(move_input != Vector2.ZERO):
		rotation = move_input.angle() + PI/2
		last_rot = rotation
	
	
	if(is_loading_throw and has_crystal):
		throw_strength += 1
	
	if(is_releasing_throw and has_crystal):
		throw(move_input)


func throw(move_input:Vector2):
	crystal.throw(throw_strength, move_input)

func body_entered(body):
	pass
