extends KinematicBody2D

# Declaires variables

onready var HitBox = $CollisionShape2D
onready var Sprite = $Sprite
var velocity = Vector2(0,0)
export var Speed = 150.0
export var MaxSpeed = 300.0
export var Acceleration = 0.6
export var player = 0
var OutOfControl = false
var followCam : Camera2D


func _ready():
	#Makes sure player doesn't start moving
	Input.action_release("Right1")
	Input.action_release("Left1")
	Input.action_release("Right2")
	Input.action_release("Left2")
	if player == 1:
		followCam = get_node("/root/SplitscreenComponent/GridContainer/container1/viewport1/Camera2D")
	elif player == 2:
		followCam = get_node("/root/SplitscreenComponent/GridContainer/container2/viewport2/Camera2D")
	
# Things that happen every second

func _physics_process(delta):
	
	# Detects Keys for Left/Right
	if OutOfControl == false:
		if Input.is_action_pressed("Right1"):
			if player == 1:
				velocity.x = lerp(velocity.x,Speed,Acceleration)
				$CollisionShape2D.scale.x = 1
				$Sprite.flip_h = false
			
		elif Input.is_action_pressed("Left1"):
			if player == 1:
				velocity.x = lerp(velocity.x,-Speed,Acceleration)
				$CollisionShape2D.scale.x = -1
				$Sprite.flip_h = true
		if Input.is_action_pressed("Right2"):
			if player == 2:
				velocity.x = lerp(velocity.x,Speed,Acceleration)
				$CollisionShape2D.scale.x = 1
				$Sprite.flip_h = false
			
		elif Input.is_action_pressed("Left2"):
			if player == 2:
				velocity.x = lerp(velocity.x,-Speed,Acceleration)
				$CollisionShape2D.scale.x = -1
				$Sprite.flip_h = true
			
	# Sets animation
	if (velocity.x > 50 or velocity.x < -50):
		$Sprite.play("Walk")
	else:
		$Sprite.play("Stand")
		
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.15)
	followCam.global_position = global_position + Vector2(0,-11)
	
	
	
