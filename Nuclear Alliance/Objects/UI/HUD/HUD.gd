extends CanvasLayer

#Variables for how much time is left till sabotage is active
var sbtgeTime = 60.0 * 60.0
var maxSbtgeTime = 60.0*60.0
var sbtgePercent = 0.0

#Variables for weather certain minigames are ready#
var power = true
var water = 0.0
var maxWater = Globals.MaxWtr
var pressure = true
var punctures = 0


# Needle position
var needlePos = 0
var needleDirection = "Down"

#Variables for random movement for power#

var powTrgt1 = rand_range(0,5)
var powTrgt2 = rand_range(0,5)
var powTrgt3 = rand_range(0,5)
var powTrgt4 = rand_range(0,5)

#Randomizer for power bars#
var powRng = RandomNumberGenerator.new()

#Variable for which player this is attached to#
export var player = 0

onready var pressureNeedle = get_node("Pressure/Pressure")

var waterPercentage = 0.0

func _ready():
	randomize()

### Every Frame ###
func _physics_process(delta):
## Updates weather minigame stations are ready ##
	if player == 1:
		water = Globals.Wtr1
		punctures = Globals.Punc1

	if player == 2:
		water = Globals.Wtr2
		punctures = Globals.Punc2

##Ensures that the Pressure gauge is rotating the right way
	if pressureNeedle.rotation_degrees <= 0:
		pressureNeedle.offset.x = -13
		pressureNeedle.position.x = 121
	else:
		pressureNeedle.offset.x = -14
		pressureNeedle.position.x = 122
	
	needlePos = (punctures * 23) - 70
	
	if needleDirection == "Down":
		pressureNeedle.rotation_degrees -= 4
	if needleDirection == "Up":
		pressureNeedle.rotation_degrees += 4
	if pressureNeedle.rotation_degrees >= needlePos + 8:
		needleDirection = "Down"
	if pressureNeedle.rotation_degrees <= needlePos - 8:
		needleDirection = "Up"
	

## Updates hud elements for powerbox ## 
	# Update bar 1 #
	if power == true:
		if $Power/TextureRect1.margin_top != powTrgt1:
			$Power/TextureRect1.margin_top = lerp($Power/TextureRect1.margin_top, powTrgt1, 0.1)
			
	# Update bar 2 #
		if $Power/TextureRect2.margin_top != powTrgt2:
			$Power/TextureRect2.margin_top = lerp($Power/TextureRect2.margin_top, powTrgt2, 0.1)
			
	# Update bar 3 #
		if $Power/TextureRect3.margin_top != powTrgt3:
			$Power/TextureRect3.margin_top = lerp($Power/TextureRect3.margin_top, powTrgt3, 0.1)
			
	# Update Bar 4 #
		if $Power/TextureRect4.margin_top != powTrgt4:
			$Power/TextureRect4.margin_top = lerp($Power/TextureRect4.margin_top, powTrgt4, 0.1)
	
	# Bring all to 0 if minigame is ready #
	else:
		$Power/TextureRect1.margin_top = lerp($Power/TextureRect1.margin_top, 7, 0.05)
		$Power/TextureRect2.margin_top = lerp($Power/TextureRect2.margin_top, 7, 0.05)
		$Power/TextureRect3.margin_top = lerp($Power/TextureRect3.margin_top, 7, 0.05)
		$Power/TextureRect4.margin_top = lerp($Power/TextureRect4.margin_top, 7, 0.05)
	
	waterPercentage = water / maxWater
	
	#21-32
	$Water/Water.position.y = 32 + ((waterPercentage * 11) * -1)
## Updates hud elements for Sabotage cooldown ##
	sbtgePercent = sbtgeTime / maxSbtgeTime
	$Sabotage/TextureRect.rect_scale.y = sbtgePercent

func Power(incomingState,incomingPlayer):
	if incomingPlayer == player:
		power = incomingState

func sbtgeTimer(incomingTime, incomingPlayer):
	if incomingPlayer == player:
		sbtgeTime = incomingTime

func _on_PwrTime_timeout():
	powTrgt1 = rand_range(0,6)
	powTrgt2 = rand_range(0,6)
	powTrgt3 = rand_range(0,6)
	powTrgt4 = rand_range(0,6)
	$Power/PwrTime.start()
	
