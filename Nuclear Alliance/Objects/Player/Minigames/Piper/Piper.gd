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
var pipeState = [1,0,0,0]
var punctureState = [0,0,0,0,0]
var gameState = "Idle"
var puncturePositions = [0,0,0,0]
var totalActivePunctures = 0

### Makes sure the minigame is ready ###
func _ready():
	self.position = Vector2(1000,1000)
	randomize()
	Break()
	puncturePositions[1] = 0
func _physics_process(delta):
	$Cursor.attachedPlayer = attachedPlayer
	
	
##Checks which punctures are idle##
	for i in range(5):
		if get_node("Punctures/Puncture" + str(i + 1)).position == Vector2(0,-100):
			punctureState[i] = 0
		else:
			punctureState[i] = 1
	
##Counts Punctures##
	totalActivePunctures = 0
	for i in range(5):
		if punctureState[i] == 1:
			totalActivePunctures += 1
	
#
##
#### Tell station and UI how many punctures there are
##
#
	
##Moves Cursor##
	$Cursor.position.x = lerp($Cursor.position.x,(selectedPipe -1)*18,0.5)
	
	if running:
##Logic for selecting a pipe##
		if gameState == "Select":

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
			if Input.is_action_just_pressed("Interact" + str(attachedPlayer)):
				if puncturePositions[selectedPipe - 1] >= 1:
						$Cursor.active = true
						gameState = "Play"



		##Updates Pipe Sprites and states##
			for i in [1,2,3,4]:
				var currentPipe = get_node("Pipes/Pipe" + str(i))
				if i == selectedPipe:
					currentPipe.play("On")
					pipeState[i - 1] = 1
					
				else:
					currentPipe.play("Off")
					pipeState[i - 1] = 0
	
	## Logic for fixing a selected pipe ##
		if gameState == "Play":
	
		##Tells cursor To move up/down
			$Cursor.active = true
		
		## UnHighlights Pipes
			for i in [1,2,3,4]:
				get_node("Pipes/Pipe" + str(i)).play("Off")



	
	### Game Loop ###
func Game(Game, callingPlayer):

## Makes sure that it is the minigame being requested ##
	if (Game == Self && callingPlayer == attachedPlayer):
		running = true
	
	## Prepares the minigame ##
		get_tree().call_group("PiperSM","Running",attachedPlayer)
		self.position = Vector2(-43,-41)
		calledPlayer = callingPlayer
		gameState = "Select"
	
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
	selectedPipe = 1
	pipeState = [1,0,0,0]
	gameState = "Idle"

## Tells the player to unlock movement ##
	get_tree().call_group("Player","Quit",attachedPlayer)

## Tells the station to "Fix" it's self and get ready for the next play ##
	get_tree().call_group("PiperSM","End",attachedPlayer)
		

### Handels breaks being fixed ###
func Fix():
	pass
	#if breaksRemaining <= 0:
	#	Quit()


func Break():
	for i in range(5):
		if punctureState[i] == 0:
			get_node("Punctures/Puncture" + str(i + 1)).position = Vector2(rand_range(1,71),rand_range(13,52))
			punctureState[i] = 1
			break


## Tells where the punctures are at any given time
func _on_PipeCheck1_area_entered(area):
	puncturePositions[0] += 1
	print("1")


func _on_PipeCheck2_area_entered(area):
	puncturePositions[1] += 1
	print("2")


func _on_PipeCheck3_area_entered(area):
	puncturePositions[2] += 1
	print("3")


func _on_PipeCheck4_area_entered(area):
	puncturePositions[3] += 1
	print("4")
