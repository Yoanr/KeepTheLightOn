extends RigidBody2D


export (int) var id_player = 1
export (float) var speed = 500
var throw_strength: int = 0
var crystal
var pj: PinJoint2D
var last_rot: float = 0
var is_disabled: bool = false
var disable_time: float = 2.0
var get_cristal: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("player")
	connect("body_entered",self,"body_entered")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(get_cristal):
		crystal.mode = RigidBody2D.MODE_CHARACTER
		get_cristal = false
	
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
	linear_velocity = move_input.normalized() * speed
	rotation = last_rot
	if(move_input != Vector2.ZERO):
		rotation = move_input.angle()
		last_rot = rotation
	
	
	if(is_loading_throw and crystal and pj):
		throw_strength += 10
	
	if(is_releasing_throw and crystal and pj):
		throw(move_input)
		throw_strength = 0


func throw(move_input:Vector2):
	$AnimatedSprite.play("default")
	crystal.mode = RigidBody2D.MODE_RIGID
	crystal.throw(throw_strength, Vector2(cos(last_rot), sin(last_rot)))
	remove_child(pj)
	pj.queue_free()
	pj = null
	add_collision_exception_with(crystal)
	yield(get_tree().create_timer(0.5), "timeout")
	remove_collision_exception_with(crystal)
	crystal = null
	


func body_entered(body):
	if(body.is_in_group("crystal") and !crystal):
		if(body.owned_state == 0):
			$AnimatedSprite.play("hold")
			crystal = body
			crystal.take()
			pj = PinJoint2D.new()
			add_child(pj)
			pj.node_a = self.get_path()
			pj.node_b = crystal.get_path()
			get_cristal = true


func disable():
	if(!is_disabled):
		is_disabled = true
		yield(get_tree().create_timer(disable_time), "timeout")
		is_disabled = false
