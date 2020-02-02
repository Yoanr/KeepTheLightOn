extends Node2D

# makes sure it's loaded first
var Zombie = preload("res://Zombie/Zombie.tscn")
onready var Generator = preload("res://Generator/Generator.tscn")
onready var Batterie = preload("res://Battery/Battery.tscn")

enum Difficulty {SWEET, REGULAR, SPICY}

# Declare member variables here.
var _generator
export (int) var _battID = 0
var _batterieIsFunctionnal = true
var _randGen = RandomNumberGenerator.new()

export (Difficulty) var difficulty = Difficulty.SWEET
var _spawnTime # time between two zombie spawns, in milliseconds
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
			_spawnTime = 4
			_zombieSpeed = 20
		Difficulty.REGULAR :
			_spawnTime = 3
			_zombieSpeed = 40
		Difficulty.SPICY :
			_spawnTime = 2.5
			_zombieSpeed = 60
	
	# to test alone (only needs Generator in scene)
	#_spawnZombies()
	pass


# Called every frame.
func _process(delta) :
	if !_initialized :
		var batterie = _generator.batteries[_battID]
		if batterie == null :
			return
		else :
			batterie.connect("batteryDestroyed", self, "onBatteryDestroyed")
			batterie.connect("batteryFunctionnal", self, "onBatteryFunctionnal")
			print("batterie connected")
			_initialized = true
	pass

func _spawnZombies(location) :
	while(!_batterieIsFunctionnal) :
		
		if _randGen.randi_range(0,100) <= 30 :
			# creates zombie
			var zombie = Zombie.instance()
			
			# sets params
			zombie.speed = _zombieSpeed
			zombie.position = location
			zombie.setTarget(_generator)
			self.add_child(zombie)
		
		# call next spawn
		yield(get_tree().create_timer(_spawnTime), "timeout")

func onBatteryDestroyed(battery) :
	print("zombies manager receives destroyed signal from battery")
	_batterieIsFunctionnal = false
	_spawnZombies(battery.position)

func onBatteryFunctionnal(battery) :
	print("zombies manager receives functionnal signal from battery")
	_batterieIsFunctionnal = true
