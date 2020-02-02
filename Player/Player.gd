extends RigidBody2D


export (int) var _id_player = 1
export (float) var _speed = 500
export (float) var _disable_time = 2.0
export (float) var _max_throw_load_time = 2.0

var _throw_load_time = 0.0
var _crystal
var last_rot: float = 0
var is_disabled: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("player")
	connect("body_entered",self,"body_entered")
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_disabled):
		linear_velocity = Vector2.ZERO
		return
	
	# Get inputs
	var id: String = "P" + String(_id_player)
	var left_input: float = Input.get_action_strength(id + "_Left")
	var right_input: float = Input.get_action_strength(id + "_Right")
	var up_input: float = Input.get_action_strength(id + "_Up")
	var down_input: float = Input.get_action_strength(id + "_Down")
	var move_input: Vector2 = Vector2(right_input - left_input, down_input - up_input)
	var is_loading_throw: bool = Input.is_action_pressed(id + "_Throw")
	var is_releasing_throw:bool = Input.is_action_just_released(id + "_Throw")
	
	# Move player
	linear_velocity = move_input.normalized() * _speed
	rotation = last_rot
	if(move_input != Vector2.ZERO):
		rotation = move_input.angle()
		last_rot = rotation
	
	
	if(is_loading_throw and _crystal):
		_throw_load_time += delta
	
	if(is_releasing_throw and _crystal):
		throw(move_input)
		_throw_load_time = 0

	
func throw(move_input:Vector2):
	$AnimatedSprite.play("default")
	_crystal.follow(null)
	_crystal.throw(throw_strength(), Vector2(cos(last_rot), sin(last_rot)))
	yield(get_tree().create_timer(0.2), "timeout")
	remove_collision_exception_with(_crystal)
	_crystal = null

func release():
	$AnimatedSprite.play("default")
	_crystal = null
	


func throw_strength():
	var x = clamp(_throw_load_time, 0, _max_throw_load_time)
	var ts = 0
	if(x < 1):
		ts = pow(x + 1, 4) * 100 + 500
	else:
		ts = 2100 + (x - 1) * 200
	return ts  


func body_entered(body):
	if(body.is_in_group("crystal") and !_crystal):
		if(body.owned_state == 0):
			$AnimatedSprite.play("hold")
			_crystal = body
			_crystal.take()
			add_collision_exception_with(_crystal)
			_crystal.follow(self)


func disable():
	if(!is_disabled):
		is_disabled = true
		$AnimatedSprite.modulate = Color(1,1,1,0.4)
		set_collision_layer_bit(0, false)
		set_collision_layer_bit(5, true)
		set_collision_mask_bit(2, false)
		yield(get_tree().create_timer(_disable_time), "timeout")
		set_collision_layer_bit(0, true)
		set_collision_layer_bit(5, false)
		set_collision_mask_bit(2, true)
		$AnimatedSprite.modulate = Color(1,1,1,1)
		is_disabled = false
