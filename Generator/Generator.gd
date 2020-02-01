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
var hp = 50
var color = "red"
var batteriesState = [integerTest.normal, integerTest.destroyed, integerTest.broken, integerTest.normal]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("current hp = " + str(hp))
	print(checkGameState())

func checkGameState() -> int:
	if hp == 0 :
		return LiveState.defeat
	if hp == 100 :
		return LiveState.victory
	return LiveState.alive

