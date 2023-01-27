extends KinematicBody2D

# The player's current velocity
var velocity = Vector2(0,0)

# The player's max speed
export var Speed = 150.0

# How fast the player accelerates
export var Acceleration = 0.6

# Weather this is player 1 or 2
export var player = 0

# Locks movement when true
var gameMode = false

#The Viewport the player is using
var followCam : Camera2D

#Which minigame the player is in interat range if any
var gameHovered = 0

### Gets the player ready ###
func _ready():

## Makes sure player doesn't start moving ##
	Input.action_release("Right1")
	Input.action_release("Left1")
	Input.action_release("Right2")
	Input.action_release("Left2")

## Attaches the correct camera ##
	if player == 1:
		followCam = get_node("/root/SplitscreenComponent/GridContainer/container1/viewport1/Camera2D")
	elif player == 2:
		followCam = get_node("/root/SplitscreenComponent/GridContainer/container2/viewport2/Camera2D")

## Makes sure that the minigames know which player they are attached to ##
##### ADD A NEW LINE FOR NEW MINIGAMES #####
	$"Minigames/Minigame1".attachedPlayer = player
	$"Minigames/Minigame2".attachedPlayer = player
	$"Minigames/Minigame3".attachedPlayer = player
	

### Everything that happens on a every-frame basis ###
func _physics_process(_delta):

## Detects keystrokes for movement and flips the player sprite & collision accordingly ##
	if gameMode == false:
		if Input.is_action_pressed("Right1"):
			if player == 1:
				velocity.x = lerp(velocity.x,Speed,Acceleration)
				$CollisionShape2D.scale.x = 1
				$Sprite.flip_h = false
			
		elif Input.is_action_pressed("Left1"):
			if player == 1:
				velocity.x = lerp(velocity.x,-Speed,Acceleration)
				$CollisionShape2D.scale.x = -1
				$Sprite.flip_h = true
		if Input.is_action_pressed("Right2"):
			if player == 2:
				velocity.x = lerp(velocity.x,Speed,Acceleration)
				$CollisionShape2D.scale.x = 1
				$Sprite.flip_h = false
			
		elif Input.is_action_pressed("Left2"):
			if player == 2:
				velocity.x = lerp(velocity.x,-Speed,Acceleration)
				$CollisionShape2D.scale.x = -1
				$Sprite.flip_h = true

## Sets sprite animation ##
	if (velocity.x > 50 or velocity.x < -50):
		$Sprite.play("Walk")
	elif gameMode == false:
		$Sprite.play("Stand")
		
## Converts keystrokes into movement and updates the camera location ##
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.15)
	followCam.global_position = global_position + Vector2(0,-11)
	
	
## Handels player Opening Minigames ##
	if Input.is_action_just_pressed("Interact1"):
		if (player == 1 &&  gameHovered != 0 && gameMode == false):
			get_tree().call_group("Minigame","Game",gameHovered,player)
			gameHovered = 0
			gameMode = true
			
	if Input.is_action_just_pressed("Interact2"):
		if (player == 2 && gameHovered != 0 && gameMode == false):
			get_tree().call_group("Minigame","Game",gameHovered,player)
			gameHovered = 0
			gameMode = true
	
	## Plays Step Sound effect
	
	if $Sprite.animation == "Walk":
		if $Sprite.frame == 1 or $Sprite.frame == 4:
			$StepSound.play()
			$StepSound.volume_db = -3
			yield(get_tree().create_timer(0.04),"timeout")
			$StepSound.volume_db = -80
			$StepSound.playing = false

### Gets what minigame is currently in interact range of the player if any ###
func Play(connectingGame, connectingGamePlayer):
	if connectingGamePlayer == player:
		gameHovered = connectingGame

### Allows the player to move after completing a minigame ###
func Quit(connectingGamePlayer):
	if connectingGamePlayer == player:
		gameMode = false

###Locks player in animation after a sabotage is selected###
func Animate(ConnectingGamePlayer,Anim,offset):
	if ConnectingGamePlayer == player:
		$Sprite.play(Anim)
		$Sprite.position = offset
		$Sprite.flip_h = false
		gameMode = true


func _on_Sprite_animation_finished():
	if $Sprite.animation == "HeatRay" or $Sprite.animation == "Tazer" or $Sprite.animation == "PBoy":
		if $Sprite.animation == "HeatRay":
			get_tree().call_group("BackDrop","Animate","HeatRay",player)
		if $Sprite.animation == "Tazer":
			get_tree().call_group("PwrBxSM","overload",player)

			
		$Sprite.play("Stand")
		gameMode = false
		$Sprite.position = Vector2(0,0)

