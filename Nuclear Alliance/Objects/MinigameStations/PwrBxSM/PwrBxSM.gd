extends Node2D


#The player that this station is attached to
export var player = 0
#Weather or not the station is marked as active
var broken = false
#Weather or not the game is currently in use
var active = false
#Weather or not a player is nearby
var hovered = false
#The amount of time it takes for the station to be marked broken
#Decreases by 5 each cycle
var timerLength = 30

var overloading = false

#The amount of time before a game over
var gameOverTimer = 15*60


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$AudioStreamPlayer.volume_db = -80.0
	$Timer.wait_time = 30
	$Timer.start()



#Tells the sprite a player is nearby
func _on_Area2D_body_entered(_body):
	hovered = true

#	Tells the sprite that a player is no longer nearby and
#tells said player that they are no longer near this station
func _on_Area2D_body_exited(_body):
	hovered = false
	get_tree().call_group("Player","playerMinigame",0, player)

#Makes it so the player can't activate the game by marking it as active
func Running():
	active = true
	
#"Fixes" the game station and marks it as no longer active
func End(callingPlayer):
	if callingPlayer == player:
		active = false
		broken = false
		$Timer.start()
		if player == 1:
			get_tree().call_group("HUD","Power",true,1)
		if player == 2:
			get_tree().call_group("HUD","Power",true,2)



func _physics_process(_delta):	
	#Highlights sprite when broken and a player is nearby
	if broken && !active && hovered && !overloading:
			$AnimatedSprite.play("Hovered")
			get_tree().call_group("Player","playerMinigame",1,player)
	
	#Other sprite states
	if (!overloading && !hovered) or (!overloading && !broken):
		if broken == false:
			$AnimatedSprite.play("Idle")
			$AudioStreamPlayer.volume_db = -80
		if broken == true:
			$AnimatedSprite.play("Broken")
			$AudioStreamPlayer.volume_db = -20
			
	#Updates hud and counts time before game over
	if broken == true:
		if player == 1:
			get_tree().call_group("HUD","Power",false,1)
		if player == 2:
			get_tree().call_group("HUD","Power",false,2)
			
		gameOverTimer -= 1
	# Resets gameOverTimer when not broken
	else:
		gameOverTimer = 15*60

	#Ends game when gameOverTime expires
	if gameOverTimer <= 0:
		Globals.failType = "PowerFail"
		Globals.playerFailed = player
		get_tree().call_group("BGLights","blackout")
		get_tree().call_group("Player","blackout", player)
		
	#Disables breaking timer when player is fixing it
	if active == true:
		$Timer.time_left = timerLength


#"Breaks" Station on when the timer runs out
func _on_Timer_timeout():
	$AnimatedSprite.play("Broken")
	timerLength -= 2 + rand_range(-1,1)
	$Timer.stop()
	$Timer.wait_time = timerLength
	broken = true


#Handels this station being sabotaged
func overload(callingPlayer):
	if callingPlayer != player:
		overloading = true
		$AnimatedSprite.play("Overload")

#When sabotage animation finishes
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Overload":
		broken = true
		overloading = false
		$AnimatedSprite.play("Broken")
		timerLength -= 2 + rand_range(-1,1)
		$Timer.stop()
		$Timer.wait_time = timerLength

