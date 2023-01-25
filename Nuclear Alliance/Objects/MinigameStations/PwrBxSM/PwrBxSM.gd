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
var timerLength = 30 + rand_range(-3,3)

var overloading = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.volume_db = -80



#Tells the sprite a player is nearby
func _on_Area2D_body_entered(body):
	hovered = true

#	Tells the sprite that a player is no longer nearby and
#tells said player that they are no longer near this station
func _on_Area2D_body_exited(body):
	hovered = false
	get_tree().call_group("Player","Play",0, player)

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
	if broken == true && active == false && hovered == true && overloading == false:
			$AnimatedSprite.play("Hovered")
			get_tree().call_group("Player","Play",1,player)
	
	#Other sprite states
	if (overloading == false && hovered == false) or (overloading == false && broken == false):
		if broken == false:
			$AnimatedSprite.play("Idle")
			$AudioStreamPlayer.volume_db = -80
		if broken == true:
			$AnimatedSprite.play("Broken")
			$AudioStreamPlayer.volume_db = -20
			
	#Updates hud
	if broken == true:
		if player == 1:
			get_tree().call_group("HUD","Power",false,1)
		if player == 2:
			get_tree().call_group("HUD","Power",false,2)
	
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


#Keeps alarm playing at all times
func _on_AudioStreamPlayer_finished():
		$AudioStreamPlayer.play()

#Handels this station being sabotaged
func overload(callingPlayer):
	print("here")
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

