extends Node2D

# The minigame's ID called by the player to make sure the right minigame is 
#running
export var Self = 0

# The player that this minigame is intended to run for
var attachedPlayer = 0

# The player that is currently asking to play this game
var calledPlayer = 0

var running = false

var selectedPipe = 1
var pipeState = [0,0,0,0]
var punctureState = [0,0,0,0,0]
var gameState = "Select"


### Makes sure the minigame is ready ###
func _ready():
	self.position = Vector2(1000,1000)
func _physics_process(delta):
	$Cursor.attachedPlayer = attachedPlayer
	
##Moves Cursor##
	$Cursor.position.x = (selectedPipe -1)*18
	
	
##Logic for selecting a pipe##
	if gameState == "Select" && running:
	
	##Cursor Left##
		if Input.is_action_just_released("Left" + str(attachedPlayer)):
			if selectedPipe == 1:
				selectedPipe = 4
			else:
				selectedPipe -= 1
	##Cursor Right##
		if Input.is_action_just_released("Right" + str(attachedPlayer)):
			if selectedPipe == 4:
				selectedPipe = 1
			else:
				selectedPipe += 1
	##Select Pipe
		if Input.is_action_just_released("Interact" + str(attachedPlayer)):
			$Cursor.active = true
			gameState = "Play"
	##Updates Pipe Sprites and states##
		for i in [1,2,3,4]:
			var currentPipe = get_node("Pipes/Pipe" + str(i))
			print(pipeState)
			if i == selectedPipe:
				currentPipe.play("On")
				pipeState[i - 1] = 1
				
			else:
				currentPipe.play("Off")
				pipeState[i - 1] = 0



	
	### Game Loop ###
func Game(Game, callingPlayer):

## Makes sure that it is the minigame being requested ##
	if (Game == Self && callingPlayer == attachedPlayer):
		running = true
		
	
	
	## Prepares the minigame ##
		get_tree().call_group("PiperSM","Running",attachedPlayer)
		self.position = Vector2(-35,-41)
		$Cursor.active = true
		calledPlayer = callingPlayer
	
	## Calls the right key prompts ##
		if calledPlayer == 1:
			$Overlay1.visible = true
		if calledPlayer == 2:
			$Overlay2.visible = true
	
 
### Ends the minigame ###
func Quit():

## Resets minigame ##
	running = false
	self.position = Vector2(1000,1000)
	$Cursor.active = false
	$Cursor.position = Vector2(0,0)

## Tells the player to unlock movement ##
	get_tree().call_group("Player","Quit",attachedPlayer)

## Tells the station to "Fix" it's self and get ready for the next play ##
	get_tree().call_group("PiperSM","End",attachedPlayer)
		

### Handels breaks being fixed ###
func Fix():
	pass
	#if breaksRemaining <= 0:
	#	Quit()
