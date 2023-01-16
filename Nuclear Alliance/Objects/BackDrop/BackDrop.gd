extends ParallaxBackground

export var attachedPlayer = 0
var maxOverheat = 10.0 * 60.0

func checkOverheat(callingStation, overheatLevel):
	if callingStation == attachedPlayer:
		$ParallaxLayer5/Sprite.modulate.a8 = (overheatLevel/maxOverheat) * 100
		print(overheatLevel)
