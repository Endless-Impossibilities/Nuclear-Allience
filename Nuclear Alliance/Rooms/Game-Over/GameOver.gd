extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.playerFailed == 1:
		$P1.visible = true
		$P1.play(Globals.failType)
	if Globals.playerFailed == 2:
		$P2.visible = true
		$P2.play(Globals.failType)
	if Globals.failType == "OverHeat":
		$OverHeat.play()
	elif Globals.failType == "PowerFail":
		$PowerFail.play()




func _on_TextureButton_pressed():
	get_tree().reload_current_scene()
	get_tree().change_scene("res://Rooms/Title/Title.tscn")
	
