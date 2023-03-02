extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var animplayed = false
var iteration = 0
var emissionAmount = 3.0
var emissionOpacity = 255
var emissionDistance = 30
var decreasingEmission = false
var brightness = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),0)
	if Globals.playerFailed == 1:
		$P1.visible = true
		$P1.play(Globals.failType)
		$P1.speed_scale = 0
	if Globals.playerFailed == 2:
		$P2.visible = true
		$P2.play(Globals.failType)
		$P2.speed_scale = 0

func _physics_process(delta):
	brightness = lerp(brightness,255,0.05)
	$CanvasModulate.color.r8 = brightness
	$CanvasModulate.color.g8 = brightness
	$CanvasModulate.color.b8 = brightness
	
	if $CanvasModulate.color.g8 >= 250:
		animation()
	
	if decreasingEmission == true:
		emissionAmount -= 0.01
		emissionOpacity -= 0.85
		emissionDistance -= 0.1
		for i in range(4):
			get_node("Timer/Burst" + str(i + 1)).speed_scale = emissionAmount
			if emissionAmount <= 0:
				get_node("Timer/Burst" + str(i + 1)).emitting = false
			get_node("Timer/Burst" + str(i + 1)).modulate.a8 = emissionOpacity
			get_node("Timer/Burst" + str(i + 1)).radial_accel = emissionDistance




func animation():

	if !animplayed:
		animplayed = true
		$P1.speed_scale = 1
		$P2.speed_scale = 1
		if Globals.failType == "OverHeat":
			$OverHeat.play()
		elif Globals.failType == "PowerFail":
			$PowerFail.play()
		elif Globals.failType == "PressureMax":
			$PressureMax.play()
			$Timer.start()


func _on_TextureButton_pressed():
	get_tree().reload_current_scene()
	get_tree().change_scene("res://Rooms/Title/Title.tscn")
	


func _on_Timer_timeout():
	if iteration == 0:
		$Timer/Burst1.emitting = true
		$Timer.wait_time = 1
		$Timer.start()
	if iteration == 1:
		$Timer/Burst2.emitting = true
		$Timer.start()
	if iteration == 2:
		$Timer/Burst3.emitting = true
		$Timer.start()
	if iteration == 3:
		$Timer/Burst4.emitting = true
		$Timer.start()
		decreasingEmission = true
	iteration += 1
	
