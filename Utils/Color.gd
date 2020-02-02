extends Node

enum ColorEnum {WHITE, RED, YELLOW, BLUE, ORANGE, GREEN, PURPLE}

var _colorMap = {ColorEnum.WHITE: Color("#FFFFFF"), ColorEnum.RED: Color("#DB0E0E"), ColorEnum.YELLOW: Color("#F2AB1D"), ColorEnum.BLUE: Color("#0073C9"), ColorEnum.ORANGE: Color("DD660E"), ColorEnum.GREEN: Color("#0B7A33"), ColorEnum.PURPLE: Color("#9048C6")}

func getColorValue(colorEnumVal) -> Color:
	return _colorMap.get(colorEnumVal)

func getMixedColor(color1,color2) -> Color:
	if(color1 == ColorEnum.RED &&  color2 == ColorEnum.YELLOW):
		return ColorEnum.ORANGE
	if(color1 == ColorEnum.RED &&  color2 == ColorEnum.BLUE):
		return ColorEnum.PURPLE
	if(color1 == ColorEnum.YELLOW &&  color2 == ColorEnum.BLUE):
		return ColorEnum.GREEN
	if(color2 == ColorEnum.RED &&  color1 == ColorEnum.YELLOW):
		return ColorEnum.ORANGE
	if(color2 == ColorEnum.RED &&  color1 == ColorEnum.BLUE):
		return ColorEnum.PURPLE
	if(color2 == ColorEnum.YELLOW &&  color1 == ColorEnum.BLUE):
		return ColorEnum.GREEN
	return color1;
	
func getMyDie(color1,color2) -> bool:
	if(color1 == ColorEnum.RED &&  color2 == ColorEnum.YELLOW):
		return false
	if(color1 == ColorEnum.RED &&  color2 == ColorEnum.BLUE):
		return true
	if(color1 == ColorEnum.YELLOW &&  color2 == ColorEnum.BLUE):
		return false
		
	if(color2 == ColorEnum.RED &&  color1 == ColorEnum.YELLOW):
		return true
	if(color2 == ColorEnum.RED &&  color1 == ColorEnum.BLUE):
		return false
	if(color2 == ColorEnum.YELLOW &&  color1 == ColorEnum.BLUE):
		return true
	return false;

func randomColor() -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(1, 6)

func randomColorCrystal() -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(1,3)
