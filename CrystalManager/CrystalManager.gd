extends Node

var crystal = preload("res://Crystal/Crystal.tscn")
onready var utilsColor = preload("res://Utils/Color.gd").new()

export (int) var nbOfcrystalsInit = 5
export (int) var nbOfcrystalsMax = 10


var crystals = []


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(nbOfcrystalsInit):
		print("crystal new")
		crystals.append(crystal.instance())
		self.add_child(crystals[i])
		setCrystals(i)

func setCrystals(crystalsId):
	var color = utilsColor.randomColorCrystal()
	crystals[crystalsId].setColor(color)

	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var x = rng.randf_range(200, 1500)
	var y = rng.randf_range(200, 800)
	var position = Vector2(x, y)
	
	crystals[crystalsId].translate(position)
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
