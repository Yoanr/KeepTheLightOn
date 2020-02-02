extends RigidBody2D
onready var utils = preload("res://Utils/Color.gd").new()

enum CrystalState{
	inactive,
	active
}

enum OwnedState{
	not_owned,
	owned
}
	

# Member variables here
var manager
var _color
var _state = CrystalState.inactive
var owned_state = OwnedState.not_owned
var _player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("crystal")
	connect("body_entered",self,"_onBodyEntered")
	# Initialize
	_setState(CrystalState.inactive)
	pass # Replace with function body.

# Called every frame
func _process(_delta):
	if(_player):
		linear_velocity = 30 * (_player.position - position + 40 * Vector2(cos(_player.last_rot), sin(_player.last_rot)))
	pass

func _onBodyEntered(body):
	print("COLlISION")
	if(body.is_in_group("crystal")):
		var crystal = body
		if(!isActive() or !crystal.isActive()):
			return
		var color2 = crystal.getColor()
		var result = utils.getMixedColor(_color,color2)
		
		if(result == _color):
			return
		
		setColor(result)
		crystal.setColor(result)
		
		if(crystal._player == null && _player != null):
			crystal.die()
			return
		if(crystal._player == null && _player == null):
			if(utils.getMyDie(_color,color2)):
				die()
				return
		if(crystal._player != null && _player == null):
			die()
			return
		if(crystal._player != null && _player != null):
			if(utils.getMyDie(_color,color2)):
				die()
		

func take():
	_setState(CrystalState.active)
	owned_state = OwnedState.owned
	pass

# Takes a force (float) and direction (Vector2, normalized or not)
func throw(force, direction):
	var impulse = force * direction.normalized()
	linear_velocity = Vector2.ZERO
	apply_central_impulse(impulse)
	owned_state = OwnedState.not_owned
	yield(get_tree().create_timer(2), "timeout")
	if _player == null :
		_setState(CrystalState.inactive)
	pass

# Change crystal state
func _setState(newState):
	if newState == CrystalState.active :
		_state = CrystalState.active
		$Sprite.modulate = Color.white
		# put on active layer :
		set_collision_layer(0)
		set_collision_layer_bit(6,true)
		# collisions with player, zombies, active crystals :
		set_collision_mask(0)
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(2, true)
		set_collision_mask_bit(6, true)

		
	if newState == CrystalState.inactive :
		_state = CrystalState.inactive
		$Sprite.modulate = Color(1,1,1,0.4)
		# put on inactive layer :
		set_collision_layer(0)
		set_collision_layer_bit(7,true)
		# collisions only with player :
		set_collision_mask(0)
		set_collision_mask_bit(0, true)


# Takes a color from utils ColorEnum 
func setColor(newColor):
	# sets internal color value
	_color = newColor
	if(_color == utils.ColorEnum.RED):
		$Sprite.set_texture(preload("res://Crystal/Assets/CrystalRed.png"))
	elif(_color == utils.ColorEnum.YELLOW):
		$Sprite.set_texture(preload("res://Crystal/Assets/CrystalYellow.png"))
	elif(_color == utils.ColorEnum.BLUE):
		$Sprite.set_texture(preload("res://Crystal/Assets/CrystalBlue.png"))
	elif(_color == utils.ColorEnum.ORANGE):
		$Sprite.set_texture(preload("res://Crystal/Assets/CrystalOrange.png"))
	elif(_color == utils.ColorEnum.PURPLE):
		$Sprite.set_texture(preload("res://Crystal/Assets/CrystalPurple.png"))
	elif(_color == utils.ColorEnum.GREEN):
		$Sprite.set_texture(preload("res://Crystal/Assets/CrystalGreen.png"))
		
	# get the matching color from the utils file and sets sprite color
func getColor():
	return _color
	
func isActive():
	return _state == CrystalState.active;

func follow(player):
	_player = player
	
func die():
	manager.crystalDied()
	if(_player != null):
		_player.release()
	get_parent().remove_child(self)
	pass
