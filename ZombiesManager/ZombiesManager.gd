extends Node2D
onready var Generator = preload("res://Generator/Generator.tscn")
var Zombie = preload("res://Zombie/Zombie.tscn")
enum Difficulty {SWEET, REGULAR, SPICY}


# Declare member variables here. Examples:
var _generator
var _spawnPosition

export (Difficulty) var difficulty = Difficulty.SWEET
var _spawnTime # time between two zombie spawns, in milliseconds
var _spawnNumber
var _spawned = 0
var _zombieSpeed

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("zombie_manager")
	
	_generator = get_tree().get_root().find_node("Generator", true, false)#get_tree().get_nodes_in_group("generator")
	if _generator == null :
		print("No Generator was found by ZombiesManager!")
	
	# sets value depending on selected difficulty
	match(difficulty):
		Difficulty.SWEET :
			_spawnNumber = 4
			_spawnTime = 1000
			_zombieSpeed = 80
		Difficulty.REGULAR :
			_spawnNumber = 6
			_spawnTime = 800
			_zombieSpeed = 120
		Difficulty.SPICY :
			_spawnNumber = 8
			_spawnTime = 500
			_zombieSpeed = 160
	
	_spawnZombies()
	pass


# Called every frame.
func _process(delta) :
	pass

func _spawnZombies() :
	while(true) :
		# creates zombie
		var zombie = Zombie.instance()
		
		# sets params
		zombie.speed = _zombieSpeed
		zombie.position = Vector2(100,243)#_spawnPosition
		zombie.setTarget(_generator)
		self.add_child(zombie)

		
		# call next spawn
		if _spawned < _spawnNumber :
			yield(get_tree().create_timer(_spawnTime), "timeout")
		else :
			return

