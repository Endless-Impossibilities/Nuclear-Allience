extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var Self = 4
var attachedPlayer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$ButtonManager.attachedPlayer = attachedPlayer
	self.position = Vector2(1000,1000)
func _physics_process(delta):
	$Cursor.attachedPlayer = attachedPlayer
	
func Game(Game, callingPlayer):
	if (Game == Self && callingPlayer == attachedPlayer):
		self.position = Vector2(0,0)
		$Cursor.active = true
func Quit(callingPlayer):
	if (callingPlayer == attachedPlayer):
		self.position = Vector2(1000,1000)
		$Cursor.active = false
		$Cursor.position = Vector2(30,0)
func Hover(hovered):
	$Cursor.hovered = hovered
	
