extends RigidBody2D

# Declare member variables here. Examples:
var _generator
var _direction = Vector2(1,1)
var _generatorPosition
var _randomGen
export (float) var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("zombie")
	_randomGen = RandomNumberGenerator.new()
	connect("body_entered",self,"onBodyEntered")
	$Area2D.connect("body_entered",self,"onTriggerEntered")
	$Area2D.connect("body_exited",self,"onTriggerExited")

	# to test individual zombie, use this to initialize it :
	#_generatorPosition = Vector2(1200, 0)
	#_follow(_generatorPosition)

func _process(delta):
	linear_velocity = _direction.normalized() * speed
	#_rotateSprite()
	pass

func setTarget(generator):
	_generator = generator
	_generatorPosition = generator.position
	_follow(_generatorPosition)
	_rotateSprite()
	pass

func _follow(targetPos):
	_direction = targetPos - position
	pass

func _rotateSprite():
	rotation = _direction.angle()
	pass

func onBodyEntered(body) :
	print("zombie body entered")
	if(body.is_in_group("crystal")) :
		var crystal = body
		if crystal.isActive():
			print("zombie entered by active crystal, will die")
			crystal.die()
			if (crystal._player):
				crystal._player.disable()
			_die()
			
	if(body.is_in_group("player")) :
		var player = body
		if !player.is_disabled :
			print("zombie kicked player")
			player.disable()
			
	if(body.is_in_group("generator")) :
		var generator = body
		print("zombie kicked generator")
		_generator.hit()
		_commitSuicide()

func onTriggerEntered(body):
	if(body.is_in_group("player")) :
		var player = body
		if !player.is_disabled :
			print("zombie follows player")
			_follow(player.position)
			_rotateSprite()
		
	if(body.get_parent().is_in_group("generator")) :
		var generator = body
		print("zombie follows generator")
		_follow(generator.position)
		_rotateSprite()
 
func onTriggerExited(body):
	_follow(_generatorPosition)

func _die():
	# todo fx
	#
	print("zombie died")
	# remove from scene
	get_parent().remove_child(self)

func _commitSuicide():
	_die()
