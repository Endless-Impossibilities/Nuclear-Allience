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

var overHeat = 0.0

var alarmPlaying = false


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
	
	if overHeat > 0:
		get_tree().call_group("BackDrop","checkOverheat",player,overHeat)
	
	## Plays Audio For emergency alarm ##
	if player == 2 && Globals.Wtr2 <= 1500:
		if alarmPlaying == false:
			$AudioStreamPlayer2D.play()
			alarmPlaying = true
		$AudioStreamPlayer2D.pitch_scale = -(Globals.Wtr2 / Globals.MaxWtr) + 2
		$AudioStreamPlayer2D.volume_db = lerp($AudioStreamPlayer2D.volume_db,-((Globals.Wtr1 / Globals.MaxWtr) * 2) - 10,0.05)
	elif player == 1 && Globals.Wtr1 <= 1500:
		if alarmPlaying == false:
			$AudioStreamPlayer2D.play()
			alarmPlaying = true
		$AudioStreamPlayer2D.pitch_scale = -(Globals.Wtr1 / Globals.MaxWtr) + 2
		$AudioStreamPlayer2D.volume_db = lerp($AudioStreamPlayer2D.volume_db,-((Globals.Wtr1 / Globals.MaxWtr) * 2) - 10,0.05)
	else:
		$AudioStreamPlayer2D.volume_db = lerp($AudioStreamPlayer2D.volume_db,-80,0.05)
		alarmPlaying == false
	
	
	
	
	
	if player == 1:
		if Globals.Wtr1 >= 0:
			if overHeat <= 0:
				Globals.Wtr1 -= 1
			if overHeat > 0:
				Globals.Wtr1 -= 3
				overHeat -= 1
			if Globals.Wtr1 < Globals.MaxWtr *.75 && active == false:
				broken = true
		else:
			Globals.failType = "OverHeat"
			Globals.playerFailed = 1
			get_tree().change_scene("res://Rooms/Game-Over/GameOver.tscn")
	if player == 2:
		if Globals.Wtr2 >= 0:
			if overHeat <= 0:
				Globals.Wtr2 -= 1
			if overHeat > 0:
				Globals.Wtr2 -= 3
				overHeat -= 1
			if Globals.Wtr2 < Globals.MaxWtr *.75 && active == false:
				broken = true
		else:
			Globals.failType = "OverHeat"
			Globals.playerFailed = 2
			get_tree().change_scene("res://Rooms/Game-Over/GameOver.tscn")



	if broken == true && active == false && playerColliding == true:
		$AnimatedSprite.play("Hovered")
		get_tree().call_group("Player","Play",2,player)
	else:
		$AnimatedSprite.play("Idle")

func overHeat(CallingStation):
	if CallingStation == player:
		overHeat = 10*60



## Resets audio after delay for alarm ##
func _on_AudioStreamPlayer2D_finished():
	if alarmPlaying == true:
		$AudioStreamPlayer2D.playing = false
		yield(get_tree().create_timer(0.25),"timeout")
		$AudioStreamPlayer2D.playing = true
		$AudioStreamPlayer2D.play()
