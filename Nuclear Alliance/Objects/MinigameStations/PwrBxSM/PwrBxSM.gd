extends Node2D


#The player that this station is attached to
export var player = 0
#Weather or not the station is marked as active
var broken = false
#Weather or not the game is currently in use
var active = false
#The amount of time it takes for the station to be marked broken
#Decreases by 5 each cycle
var timerLength = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



#Highlights the station's sprite if it is broken and the player is nearby
func _on_Area2D_body_entered(body):
	if broken == true && active == false:
		$AnimatedSprite.play("Hovered")
		get_tree().call_group("Player","Play",1,player)


func _on_Area2D_body_exited(body):
		$AnimatedSprite.play("Idle")
		get_tree().call_group("Player","Play",0, player)

#Makes it so the player can't activate the game by marking it as active
func Running():
	active = true
	
#"Fixes" the game station and marks it as no longer active
func End():
	active = false
	broken = false
	
func _physics_process(delta):
	if active == true:
		$Timer.time_left = timerLength




func _on_Timer_timeout():
	timerLength -= 5
	$Timer.time_left = timerLength
	broken == true
