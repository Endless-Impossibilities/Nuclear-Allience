extends Node2D


#The player that this station is attached to
export var player = 0
#Weather or not the station is marked as active
var broken = false
#Weather or not the game is currently in use
var active = false

var playerClose = false

var numPunctures = 0

var currentPunctures = 0

var miniPuncture = preload("res://Objects/MinigameStations/PiperSM/MiniPuncture.tscn")



#Highlights the station's sprite if it is broken and the player is nearby
func _on_Area2D_body_entered(body):
	playerClose = true



func _physics_process(_delta):
	
	if player == 1:
		Globals.Punc1 = currentPunctures
	else:
		Globals.Punc2 = currentPunctures
	
	
	if playerClose && broken && !active:
		$AnimatedSprite.play("Hovered")
		get_tree().call_group("Player","playerMinigame",4,player)
	else:
		$AnimatedSprite.play("Idle")

func _on_Area2D_body_exited(body):
	playerClose = false
	$AnimatedSprite.play("Hovered")
	get_tree().call_group("Player","playerMinigame",0,player)

#Makes it so the player can't activate the game by marking it as active
func Running():
	active = true
	
#"Fixes" the game station and marks it as no longer active
func End(callingPlayer):
	if callingPlayer == player:
		active = false
		broken = false
		$Timer.start()
		currentPunctures = 0
		for i in range(numPunctures):
			get_node("miniPuncture" + str(i)).Fix()

func addPuncture(callingGame,x,y):
	if callingGame == player:
		broken = true
		var instance = miniPuncture.instance()
		add_child(instance)
		instance.position = Vector2(x*0.61,(y*0.61) + 12)
		instance.name = "miniPuncture" + str(numPunctures)
		numPunctures += 1
		currentPunctures += 1


