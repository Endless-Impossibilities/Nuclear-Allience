extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var Self = 0
var attachedPlayer = 0

func _ready():
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
		$Cursor.position = Vector2(0,0)
	
