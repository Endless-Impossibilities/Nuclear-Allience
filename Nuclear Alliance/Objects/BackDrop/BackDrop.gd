extends ParallaxBackground

export var attachedPlayer = 0
var maxOverheat = 10.0 * 60.0

func checkOverheat(callingStation, overheatLevel):
	if callingStation == attachedPlayer:
		$ParallaxLayer5/Sprite.modulate.a8 = lerp($ParallaxLayer5/Sprite.modulate.a8,(overheatLevel/maxOverheat) * 100, 0.05)


func Animate(Anim,callingPlayer):
	if callingPlayer != attachedPlayer:
		$ParallaxLayer5/AnimatedSprite.play(Anim)

	

func _on_AnimatedSprite_animation_finished():
	if $ParallaxLayer5/AnimatedSprite.animation == "HeatRay":
		get_tree().call_group("WtrPmpSM", "overHeat", attachedPlayer)
	$ParallaxLayer5/AnimatedSprite.play("Default")

