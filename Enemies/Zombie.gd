extends RigidBody2D

# Declare member variables here. Examples:
var _direction
var _generatorPosition
var _randomGen
export (float) var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	_randomGen = RandomNumberGenerator.new()
	connect("body_entered",self,"onBodyEntered")
	$Area2D.connect("body_entered",self,"onTriggerEntered")
	$Area2D.connect("body_exited",self,"onTriggerExited")

	# to test individual zombie, use this to initialize it :
	#_generatorPosition = Vector2(1200, 0)
	#_follow(_generatorPosition)

func _process(delta):
	linear_velocity = _direction.normalized() * speed
	pass

func setTarget(generator):
	_generatorPosition = generator.position
	_follow(_generatorPosition)
	_rotateSprite()
	pass

func _follow(targetPos):
	_direction = targetPos - position
	_rotateSprite()
	pass

func _rotateSprite():
	rotation = _direction.angle()
	pass

func onBodyEntered(body) :
	if(body.is_in_group("crystal")) :
		var crystal = body
		if crystal.isACtive():
			print("zombie entered by active crystal, will die")
			_die()
			
	if(body.is_in_group("player")) :
		var player = body
		if !player.isDisabled() :
			print("zombie kicked player")
			player.disable()

func onTriggerEntered(body):
	if(body.is_in_group("player")) :
		var player = body
		if !player.isDisabled() :
			print("zombie follows player")
			_follow(player.position)
 
func onTriggerExited(body):
	print("zombie trigger exited")
	_follow(_generatorPosition)

func _die():
	# todo fx
	#
	
	# remove from scene
	get_parent().remove_child(self)
