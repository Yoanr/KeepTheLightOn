extends RigidBody2D
# Declare member variables here. Examples:
onready var utilsColor = preload("res://Utils/Color.gd").new()
var Battery = preload("res://Battery/Battery.tscn")
onready var SFXPVUp = preload("res://Generator/SFX/GeneratorPVUp.wav")
onready var SFXPVDown = preload("res://Generator/SFX/GeneratorPVDown.wav")

export (int) var nbOfBatteries = 4
export (int) var zombieDamage = 5

enum liveState {
	defeat,
	alive,
	victory
}

var elapsedTime = 0.0
var refreshGeneratorHpTimer = 10.0
var hp = 50.0
var color = 0
var batteries = []

func _ready():
	add_to_group("generator")
	
	$Area2D.connect("body_entered", self, "onBodyEntered")
	
	for i in range(nbOfBatteries):
		batteries.append(Battery.instance())
		self.add_child(batteries[i])
		setBatteries(i)
	
	changeColor()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsedTime += delta
	if elapsedTime >= refreshGeneratorHpTimer:
		hp += refreshGeneratorHp()
		print("HP = [" + str(hp) + "]")
	checkGameState()
	$AnimatedSprite.modulate.a = hp / 100

func setBatteries(batteryId):
	var position = Vector2(0.0, 0.0)
	
	if batteryId == 0:
		var angle = Vector2(0.0, -1.0)
		position.x = -900.0
		position.y = 0.0
		batteries[batteryId].rotate(angle.angle())
	if batteryId == 1:
		var angle = Vector2(0.0, 1.0)
		position.x = 900.0
		position.y = 0.0
		batteries[batteryId].rotate(angle.angle())
	if batteryId == 2:
		var angle = Vector2(1.0, 0.0)
		position.x = 0.0
		position.y = -480.0
		batteries[batteryId].rotate(angle.angle())
	if batteryId == 3:
		var angle = Vector2(-1.0, 0.0)
		position.x = 0.0
		position.y = 420.0 
		batteries[batteryId].rotate(angle.angle())
	batteries[batteryId].translate(position)
	pass
	
func checkGameState() -> int:
	if hp <= 0 :
		get_tree().change_scene("res://Scenes/MenuScene/MenuScene.tscn")
		return liveState.defeat
	if hp >= 100 :
		get_tree().change_scene("res://Scenes/MenuScene/MenuScene.tscn")
		return liveState.victory
	return liveState.alive

func refreshGeneratorHp() -> int:	
	elapsedTime = 0.0
	return getBatterisState() - 2

func getBatterisState() -> int:
	var availableBatteries = 4
	
	for battery in batteries:
		if battery.getState() == battery.State.DESTROYED:
			availableBatteries -= 1
	return availableBatteries

func changeColor() :
	var oldColor = color
	
	while color == oldColor :
		color = randi() % 6 + 1
	print("[oldColor] = " + str(oldColor) + " [color] = " + str(color))
	$AnimatedSprite.modulate = utilsColor.getColorValue(color)

func hit() :
	hp -= zombieDamage
	get_tree().get_nodes_in_group("vfxplayer")[0].stream = SFXPVDown
	get_tree().get_nodes_in_group("vfxplayer")[0].play()
	if hp < 0 :
		hp = 0

func onBodyEntered(body) :
	print("col")
	if(body.is_in_group("crystal")) :
		var crystal = body
		accept(crystal)


func accept(crystal) :
	if crystal.isActive() and crystal.getColor() == color :
		hp += 5
		changeColor()
		get_tree().get_nodes_in_group("vfxplayer")[0].stream = SFXPVUp
		get_tree().get_nodes_in_group("vfxplayer")[0].play()
		crystal.die()
	else :
		hp -= 5
		get_tree().get_nodes_in_group("vfxplayer")[0].stream = SFXPVDown
		get_tree().get_nodes_in_group("vfxplayer")[0].play()
		crystal.die()
