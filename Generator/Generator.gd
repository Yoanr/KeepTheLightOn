extends Node2D
# Declare member variables here. Examples:
enum integerTest{
	destroyed,
	broken,
	normal
}

enum LiveState {
	defeat,
	alive,
	victory
}

var elapsedTime = 0.0
var refreshGeneratorHpTimer = 10.0
var hp = 50
var color = 0
var batteriesState = [integerTest.normal, integerTest.destroyed, integerTest.broken, integerTest.normal]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsedTime += delta
	#print("elapsedTime = " + str(elapsedTime))
	if elapsedTime >= refreshGeneratorHpTimer:
		hp += refreshGeneratorHp()
		print("HP = [" + str(hp) + "]")
	connect("body_entered",self, "collide")
	checkGameState()

func checkGameState() -> int:
	if hp <= 0 :
		return LiveState.defeat
	if hp >= 100 :
		return LiveState.victory
	return LiveState.alive

func refreshGeneratorHp() -> int:	
	elapsedTime = 0.0
	return getBatterisState() - 2

func getBatterisState() -> int:
	var availableBatteries = 4
	
	for state in batteriesState :
		if state == integerTest.destroyed:
			availableBatteries -= 1
	return availableBatteries

func changeColor() :
	var oldColor = color
	
	while color == oldColor :
		color = randi() % 6
	print("[oldColor] = " + str(oldColor) + " [color] = " + str(color))

func collide(body) ->bool:
	print("COLLIDE")
	return true
