extends Node

enum colorEnum {RED, YELLOW, BLUE, ORANGE, GREEN, PURPLE}

var _colorMap = {colorEnum.RED: Color.red, colorEnum.YELLOW: Color.yellow, colorEnum.BLUE: Color.blue, colorEnum.ORANGE: Color.orange, colorEnum.GREEN: Color.green, colorEnum.PURPLE: Color.purple}

func getColorValue(colorEnumVal) -> Color:
	return _colorMap.get(colorEnumVal)

func randomColor() -> Color:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var value = rng.randi_range(0, 5)
	return getColorValue(value)
