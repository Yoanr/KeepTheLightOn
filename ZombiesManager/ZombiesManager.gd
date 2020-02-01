extends Node2D

# makes sure it's loaded first
onready var Generator = preload("res://Generator/Generator.tscn")
onready var Batterie = preload("res://Battery/Battery.tscn")

onready var Zombie = preload("res://Zombie/Zombie.tscn")
enum Difficulty {SWEET, REGULAR, SPICY}

# Declare member variables here.
var _generator
var _spawnPosition

export (Difficulty) var difficulty = Difficulty.SWEET
var _spawnTime # time between two zombie spawns, in milliseconds
var _spawnNumber
var _spawned = 0
var _zombieSpeed

var _initialized = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("zombie_manager")
	
	_generator = get_tree().get_root().find_node("Generator", true, false)#get_tree().get_nodes_in_group("generator")
	if _generator == null :
		print("No Generator was found by ZombiesManager!")

	print(_generator.batteries.size())
	
	# sets value depending on selected difficulty
	match(difficulty):
		Difficulty.SWEET :
			_spawnNumber = 4
			_spawnTime = 2
			_zombieSpeed = 80
		Difficulty.REGULAR :
			_spawnNumber = 5
			_spawnTime = 1.5
			_zombieSpeed = 100
		Difficulty.SPICY :
			_spawnNumber = 7
			_spawnTime = 1
			_zombieSpeed = 140
	
	# to test alone (only needs Generator in scene)
	#_spawnZombies()
	pass


# Called every frame.
func _process(delta) :
	if !_initialized :
		var batteries = get_tree().get_nodes_in_group("battery")
		if batteries.size() == 0 :
			return
		else :
			for b in _generator.batteries :
				b.connect("batteryDestroyed", self, "onBatteryDestroyed")
				print("batterie connected")
			_initialized = true
	pass

func _spawnZombies() :
	while(true) :
		# creates zombie
		var zombie = Zombie.instance()
		
		# sets params
		zombie.speed = _zombieSpeed
		zombie.position = _spawnPosition
		zombie.setTarget(_generator)
		self.add_child(zombie)
		
		# call next spawn
		_spawned += 1
		if _spawned < _spawnNumber :
			yield(get_tree().create_timer(_spawnTime), "timeout")
		else :
			_spawned = 0
			return

func onBatteryDestroyed(battery) :
	print("zombies manager receives signal from battery")
	_spawnPosition = battery.position
	_spawnZombies()
