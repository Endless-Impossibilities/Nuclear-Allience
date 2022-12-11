extends Node2D

# The minigame's ID called by the player to make sure the right minigame is 
#running
export var Self = 0

# The player that this minigame is intended to run for
var attachedPlayer = 0

# The player that is currently asking to play this game
var calledPlayer = 0

var waitingOn = "Left"
var locked = true

### Makes sure the minigame is ready ###
func _ready():
	self.position = Vector2(1000,1000)

	
func _physics_process(delta):
	
## Continually moves the line in the meter down ##
	if $Meter/MeterControl.position.y >= 25:
		$Meter/MeterControl.position.y = 25
	else:
		$Meter/MeterControl.position.y += .2
	
## Tracks player input ##
	if Input.is_action_just_pressed("Left" + str(attachedPlayer)) && locked == false && waitingOn == "Left":
		$Meter/MeterControl.position.y -= 2
		waitingOn = "Right"
	if Input.is_action_just_pressed("Right" + str(attachedPlayer)) && locked == false && waitingOn == "Right":
		$Meter/MeterControl.position.y -= 2
		waitingOn = "Left"
	
	if waitingOn == "Left":
		$"Letter Icons/Left".play("On")
		$"Letter Icons/Right".play("Off")
	else:
		$"Letter Icons/Left".play("Off")
		$"Letter Icons/Right".play("On")
		
	if $Meter/MeterControl.position.y > $Meter/MeterMarker.position.y && $Meter/MeterControl.position.y < $Meter/MeterMarker.position.y +10:
		if attachedPlayer == 1:
			Globals.Wtr1 += Globals.MaxWtr * 0.005
			if Globals.Wtr1 >= Globals.MaxWtr:
				Globals.Wtr1 = Globals.MaxWtr
				Quit()
		if attachedPlayer == 2:
			Globals.Wtr2 += Globals.MaxWtr * 0.005
			if Globals.Wtr2 >= Globals.MaxWtr:
				Globals.Wtr2 = Globals.MaxWtr
				Quit()

	
	if attachedPlayer == 1:
		$Plate/TextureRect.rect_scale.y = Globals.Wtr1 / Globals.MaxWtr
		$"Letter Icons/Left/Label".text = "a"
		$"Letter Icons/Right/Label".text = "d"
	elif attachedPlayer == 2:
		$Plate/TextureRect.rect_scale.y = Globals.Wtr2 / Globals.MaxWtr
		$"Letter Icons/Left/Label".text = "← "
		$"Letter Icons/Right/Label".text = "→ "
		
	if $Meter/MeterControl.position.y <= -10:
		$Meter/MeterControl.position.y = -10
	### Game Loop ###
func Game(Game, callingPlayer):

## Makes sure that it is the minigame being requested ##
	if (Game == Self && callingPlayer == attachedPlayer):
	## Prepares the minigame ##
		get_tree().call_group("WtrPmpSM","Running",attachedPlayer)
		self.position = Vector2(-10,-12)
		$Meter/MeterMarker.position.y = rand_range(-15,5)
		calledPlayer = callingPlayer
		locked = false
		waitingOn = "Left"
		


 
### Ends the minigame ###
func Quit():

## Resets minigame ##
	self.position = Vector2(1000,1000)
	locked = true

## Tells the player to unlock movement ##
	get_tree().call_group("Player","Quit",attachedPlayer)

## Tells the station to "Fix" it's self and get ready for the next play ##
	get_tree().call_group("WtrPmpSM","End",attachedPlayer)
		
