extends Node2D


#The player that this station is attached to
export var player = 0
#Weather or not the station is marked as active
var broken = false
#Weather or not the game is currently in use
var active = false
#The amount of time it takes for the station to be marked broken
#Decreases by 5 each cycle
var timerLength = 30 + rand_range(-3,3)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.volume_db = -80



#Highlights the station's sprite if it is broken and the player is nearby
func _on_Area2D_body_entered(body):
	if broken == true && active == false:
		$AnimatedSprite.play("Hovered")
		get_tree().call_group("Player","Play",1,player)


func _on_Area2D_body_exited(body):
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
	if active == true:
		$Timer.time_left = timerLength


func _on_Timer_timeout():
	$AnimatedSprite.play("Broken")
	timerLength -= 2 + rand_range(-1,1)
	$Timer.stop()
	$Timer.wait_time = timerLength
	broken = true
	if player == 1:
		get_tree().call_group("HUD","Power",false,1)
	if player == 2:
		get_tree().call_group("HUD","Power",false,2)


func _on_AudioStreamPlayer_finished():
	if broken == false:
		$AnimatedSprite.play("Idle")
		$AudioStreamPlayer.volume_db = -80
	if broken == true:
		$AnimatedSprite.play("Broken")
		$AudioStreamPlayer.volume_db = -20
	$AudioStreamPlayer.play()
