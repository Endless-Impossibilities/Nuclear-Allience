extends Node2D


export var Self = 4
export var attachedPlayer = 0
var active = false

# Sets up game for first time #
func _ready():
	$ButtonManager.attachedPlayer = attachedPlayer
	self.position = Vector2(1000,1000)
	

func _physics_process(delta):
	$Cursor.attachedPlayer = attachedPlayer
	
	## Tells which animation to play when an option is chosen ##
		# Player 1 #
	if Input.is_action_just_released("Interact1") && attachedPlayer == 1 && active == true:
		if $Cursor.hovered == "HRay":
			Quit(attachedPlayer)
			get_tree().call_group("Player","Animate",attachedPlayer,"HeatRay",Vector2(24,-13))
			get_tree().call_group("SbtgeSM","End",attachedPlayer)
			$Cursor.hovered = "None"
		if $Cursor.hovered == "Tazer":
			Quit(attachedPlayer)
			get_tree().call_group("Player","Animate",attachedPlayer,"Tazer",Vector2(3,0))
			$Cursor.hovered = "None"
		if $Cursor.hovered == "PBoy":
			Quit(attachedPlayer)
			get_tree().call_group("Player","Animate",attachedPlayer,"PBoy",Vector2(24,-13))
			get_tree().call_group("SbtgeSM","End",attachedPlayer)
			$Cursor.hovered = "None"
		# Player 2#
	if Input.is_action_just_released("Interact2") && attachedPlayer == 2 && active == true:
		if $Cursor.hovered == "HRay":
			Quit(attachedPlayer)
			get_tree().call_group("Player","Animate",attachedPlayer,"HeatRay",Vector2(24,-13))
			get_tree().call_group("SbtgeSM","End",attachedPlayer)
			$Cursor.hovered = "None"
		if $Cursor.hovered == "Tazer":
			Quit(attachedPlayer)
			get_tree().call_group("Player","Animate",attachedPlayer,"Tazer",Vector2(3,0))
			$Cursor.hovered = "None"
		if $Cursor.hovered == "PBoy":
			Quit(attachedPlayer)
			get_tree().call_group("Player","Animate",attachedPlayer,"PBoy",Vector2(24,-13))
			get_tree().call_group("SbtgeSM","End",attachedPlayer)
			$Cursor.hovered = "None"
	

#Sets Up table
func Game(Game, callingPlayer):
	if (Game == Self && callingPlayer == attachedPlayer):
		active = true
		self.position = Vector2(8,0)
		$Cursor.active = true
		if attachedPlayer == 1:
			Input.action_release("Interact1")
			$Overlay1.visible = true
		if attachedPlayer == 2:
			Input.action_release("Interact2")
			$Overlay2.visible = true
#Closes Menu#
func Quit(callingPlayer):
	if (callingPlayer == attachedPlayer):
		self.position = Vector2(1000,1000)
		$Cursor.active = false
		$Cursor.position = Vector2(30,0)
		active = false
		
#Tells the cursor what it is hovering over#
func Hover(hovered):
	$Cursor.hovered = hovered
	
	
