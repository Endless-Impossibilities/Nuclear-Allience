extends Node2D


#The player that this station is attached to
export var player = 0
#Weather or not the station is marked as active
var broken = false
#Weather or not the game is currently in use
var active = false
#The amount of time it takes for the station to be marked broken
#Decreases by 5 each cycle
var playerColliding = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.Wtr1 = Globals.MaxWtr
	Globals.Wtr2 = Globals.MaxWtr



#Highlights the station's sprite if it is broken and the player is nearby
func _on_Area2D_body_entered(body):
	playerColliding = true


func _on_Area2D_body_exited(body):
	playerColliding = false
	if broken == true:
		get_tree().call_group("Player","Play",0, player)
#Makes it so the player can't activate the game by marking it as active
func Running():
	active = true


	
	
#"Fixes" the game station and marks it as no longer active
func End(callingPlayer):
	if callingPlayer == player:
		active = false
		broken = false
	
func _physics_process(_delta):
	if player == 1 && Globals.Wtr1 >= 0:
		Globals.Wtr1 -= 1
		if Globals.Wtr1 < Globals.MaxWtr *.75 && active == false:
			broken = true
	if player == 2 && Globals.Wtr1 >= 0:
		Globals.Wtr2 -= 1
		if Globals.Wtr2 < Globals.MaxWtr *.75 && active == false:
			broken = true
	if broken == true && active == false && playerColliding == true:
		$AnimatedSprite.play("Hovered")
		get_tree().call_group("Player","Play",2,player)
	else:
		$AnimatedSprite.play("Idle")


