extends Node2D

onready var Tazer = get_node("Tazer/AnimatedSprite")
onready var PBoy = get_node("PressureBoy/AnimatedSprite")
onready var HRay = get_node("HeatRay/AnimatedSprite")

var hovered = "None"
var attachedPlayer = 1

func _ready():
	Tazer.play("off")
	PBoy.play("off")
	HRay.play("off")

func _physics_process(delta):
	$"..".Hover(hovered)


func _on_TazerCollision_body_entered(body):
	Tazer.play("on")
	hovered = "Tazer"



func _on_PBoyCollision_body_entered(body):
	PBoy.play("on")
	hovered = "PBoy"


func _on_HeatRayCollision_body_entered(body):
	HRay.play("on")
	hovered = "HRay"



func _on_TazerCollision_body_exited(body):
	Tazer.play("off")
	hovered = "None"


func _on_PBoyCollision_body_exited(body):
	PBoy.play("off")
	hovered = "None"


func _on_HeatRayCollision_body_exited(body):
	HRay.play("off")
	hovered = "None"

