extends Node2D

export var player = 0
var playing = false
var broken = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if broken == true:
		$AnimatedSprite.play("Hovered")
		get_tree().call_group("Player","Play",1,player)

func _on_Area2D_body_exited(body):
		$AnimatedSprite.play("Idle")
		get_tree().call_group("Player","Play",0, player)


func Running():
	broken = false

func End():
	broken = true
	

