extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var Self = 0
var attachedPlayer = 0
var breaksRemaining = 3
var calledPlayer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = Vector2(1000,1000)
func _physics_process(delta):
	$Cursor.attachedPlayer = attachedPlayer
	
func Game(Game, callingPlayer):
	if (Game == Self && callingPlayer == attachedPlayer):
		get_tree().call_group("PwrBxSM","Running",attachedPlayer)
		self.position = Vector2(0,0)
		$Cursor.active = true
		breaksRemaining = 3
		calledPlayer = callingPlayer
		
		$Break1.position.x = rand_range(-16,9)
		$Break2.position.x = rand_range(-16,9)
		$Break3.position.x = rand_range(-16,9)
		$Break1.position.y = rand_range(-36,7)
		$Break2.position.y = rand_range(-36,7)
		$Break3.position.y = rand_range(-36,7)
		$Break1.Break()
		$Break2.Break()
		$Break3.Break()
		
func Quit():
	self.position = Vector2(1000,1000)
	$Cursor.active = false
	$Cursor.position = Vector2(0,0)
	get_tree().call_group("Player","Quit",attachedPlayer)
	get_tree().call_group("PwrBxSM","End",attachedPlayer)
		


func Fix():
	breaksRemaining -= 1
	if breaksRemaining <= 0:
		Quit()
