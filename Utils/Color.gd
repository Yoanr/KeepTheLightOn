extends Node

enum ColorEnum {WHITE, RED, YELLOW, BLUE, ORANGE, GREEN, PURPLE}

var _colorMap = {ColorEnum.WHITE: Color.white, ColorEnum.RED: Color.red, ColorEnum.YELLOW: Color.yellow, ColorEnum.BLUE: Color.blue, ColorEnum.ORANGE: Color.orange, ColorEnum.GREEN: Color.green, ColorEnum.PURPLE: Color.purple}

func getColorValue(colorEnumVal) -> Color:
	return _colorMap.get(colorEnumVal)

func randomColor() -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(1, 6)

func randomColorCrystal() -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(1,3)
