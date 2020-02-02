extends Node

var Crystal = preload("res://Crystal/Crystal.tscn")
onready var utilsColor = preload("res://Utils/Color.gd").new()

export (int) var nbOfcrystalsInit = 10
export (int) var nbOfcrystalsMax = 10



# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(nbOfcrystalsInit):
		var newcrystal = Crystal.instance()
		print("crystal new")
		newcrystal.manager = self
		self.add_child(newcrystal)
		setCrystals(newcrystal)

func setCrystals(newcrystal):
	var color = utilsColor.randomColorCrystal()
	newcrystal.setColor(color)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var x = rng.randf_range(200, 1500)
	var y = rng.randf_range(200, 800)
	
	while(x < 1060  && x > 860 && y < 600 && y > 480):
		rng.randomize()
		x = rng.randf_range(200, 1500)
		y = rng.randf_range(200, 800)
		
	var position = Vector2(x, y)
	newcrystal.translate(position)

	

func crystalDied():
	var newcrystal = Crystal.instance()
	newcrystal.manager = self
	self.add_child(newcrystal)
	setCrystals(newcrystal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
