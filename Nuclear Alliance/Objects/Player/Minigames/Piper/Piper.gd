extends Node2D

# The minigame's ID called by the player to make sure the right minigame is 
#running
export var Self = 0

# The player that this minigame is intended to run for
var attachedPlayer = 0

# How many breakpoints still need to be fixed
var breaksRemaining = 3

# The player that is currently asking to play this game
var calledPlayer = 0

#Preload the path for the punctures
var pips = load("res://Objects/Player/Minigames/Piper/Puncture.tscn")

#Load the path the into an instance
var suc = pips.instance()

### Makes sure the minigame is ready ###
func _ready():
	self.position = Vector2(1000,1000)
func _physics_process(delta):
	$Cursor.attachedPlayer = attachedPlayer
	
	
	### Game Loop ###
func Game(Game, callingPlayer):

## Makes sure that it is the minigame being requested ##
	if (Game == Self && callingPlayer == attachedPlayer):
		print("Did you know?")
		
	
	
	## Prepares the minigame ##
		get_tree().call_group("PiperSM","Running",attachedPlayer)
		self.position = Vector2(-10,0)
		$Cursor.active = true
		breaksRemaining = 3
		calledPlayer = callingPlayer
	
	## Calls the right key prompts ##
		if calledPlayer == 1:
			$Overlay1.visible = true
		if calledPlayer == 2:
			$Overlay2.visible = true
	
 
### Ends the minigame ###
func Quit():

## Resets minigame ##
	self.position = Vector2(1000,1000)
	$Cursor.active = false
	$Cursor.position = Vector2(0,0)

## Tells the player to unlock movement ##
	get_tree().call_group("Player","Quit",attachedPlayer)

## Tells the station to "Fix" it's self and get ready for the next play ##
	get_tree().call_group("PiperSM","End",attachedPlayer)
		

### Handels breaks being fixed ###
func Fix():
	breaksRemaining -= 1
	if breaksRemaining <= 0:
		Quit()

func punc(puncX,puncY):
	add_child(suc)
	suc.position = Vector2(puncX,puncY)
