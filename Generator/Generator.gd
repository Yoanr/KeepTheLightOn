extends Node2D
# Declare member variables here. Examples:
onready var utilsColor = preload("res://Utils/Color.gd").new()
var Battery = preload("res://Battery/Battery.tscn")
export (int) var nbOfBatteries = 4
export (int) var zombieDamage = 5

enum liveState {
	defeat,
	alive,
	victory
}

var elapsedTime = 0.0
var refreshGeneratorHpTimer = 10.0
var hp = 50
var color = 0
var batteries = []

func _ready():
	#$RigidBody2D.connect("body_entered",self, "collide")
	add_to_group("generator")
	
	for i in range(nbOfBatteries):
		batteries.append(Battery.instance())
		self.add_child(batteries[i])
		setBatteries(i)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsedTime += delta
	if elapsedTime >= refreshGeneratorHpTimer:
		hp += refreshGeneratorHp()
		print("HP = [" + str(hp) + "]")
	checkGameState()

func setBatteries(batteryId):
	var position = Vector2(0.0, 0.0)
	
	if batteryId == 0:
		position.x = -912.0
		position.y = 0.0
	if batteryId == 1:
		position.x = 912.0
		position.y = 0.0
	if batteryId == 2:
		position.x = 0.0
		position.y = -492.0
	if batteryId == 3:
		position.x = 0.0
		position.y = 492.0 
	batteries[batteryId].translate(position)
	batteries[batteryId].set_texture(preload("res://icon.png"))
	pass
	
func checkGameState() -> int:
	if hp <= 0 :
		return liveState.defeat
	if hp >= 100 :
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
		color = randi() % 6
	print("[oldColor] = " + str(oldColor) + " [color] = " + str(color))

func hit() :
	hp -= zombieDamage
	if hp < 0 :
		hp = 0
