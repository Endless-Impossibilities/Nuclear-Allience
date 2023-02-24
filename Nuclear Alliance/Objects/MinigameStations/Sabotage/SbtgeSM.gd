extends Node2D

var playerColliding = false
#The player that this station is attached to
export var player = 0
#Weather or not the station is marked as active
var avalible = false
#Weather or not the game is currently in use
var active = false
#The amount of time it takes for the station to be available
var time = 0
var maxTime = 60*60



#Highlights the station's sprite if it is broken and the player is nearby
func _on_Area2D_body_entered(body):
	playerColliding = true


func _on_Area2D_body_exited(body):
		playerColliding = false
		get_tree().call_group("Player","Play",0,player)

#Makes it so the player can't activate the game by marking it as active
func Running():
	active = true
	
#"Fixes" the game station and marks it as no longer active
func End(callingPlayer):
	if callingPlayer == player:
		active = false
		avalible = false
		time = maxTime
		get_tree().call_group("Player","Play",0,player)

	
func _physics_process(delta):
	if time <= 0:
		time = 0
		avalible = true
	else:
		time -= 1
	get_tree().call_group("HUD","sbtgeTimer",time,player)
	if avalible == true && active == false && playerColliding == true:
		$AnimatedSprite.play("hovered")
		get_tree().call_group("Player","Play",3,player)
	else:
		$AnimatedSprite.play("idle")


