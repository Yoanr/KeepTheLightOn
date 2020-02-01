extends Node2D

export (int) var numberOfPlayer = 2

export (int) var minimumOfPlayer = 2
export (int) var maximumOfPlayer = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Quit_button_down():
	get_tree().quit()


func _on_Start_button_down():
	get_tree().change_scene("res://Scenes/MainScene/MainScene.tscn")


func plus_on__button_down():
	if(numberOfPlayer < maximumOfPlayer):
		numberOfPlayer = numberOfPlayer+1
		$NbOfPlayer.text = str(numberOfPlayer)
		print(numberOfPlayer)


func minus_on__button_down():
	if(numberOfPlayer > minimumOfPlayer):
		numberOfPlayer = numberOfPlayer-1
		$NbOfPlayer.text = str(numberOfPlayer)
		print(numberOfPlayer)
