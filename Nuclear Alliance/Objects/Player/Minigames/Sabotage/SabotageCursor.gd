extends KinematicBody2D

var velocity = Vector2(0,0)
var active = true
var attachedPlayer = 1
var PreviousX = 0
var PreviousY = 0
var speed = 65
var hovered = "None"
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	
	
	PreviousX = self.position.x
	PreviousY = self.position.y
	
	if (active == true):
		if (attachedPlayer == 1):
			if Input.is_action_pressed("Left1"):
				velocity.x = -speed
			if Input.is_action_pressed("Right1"):
				velocity.x = speed
			if Input.is_action_pressed("Up1"):
				velocity.y = -speed
			if Input.is_action_pressed("Down1"):
				velocity.y = speed
		if (attachedPlayer == 2):
			if Input.is_action_pressed("Left2"):
				velocity.x = -speed
			if Input.is_action_pressed("Right2"):
				velocity.x = speed
			if Input.is_action_pressed("Up2"):
				velocity.y = -speed
			if Input.is_action_pressed("Down2"):
				velocity.y = speed
		velocity = Vector2(lerp(velocity,Vector2(0,0),0.5))
		move_and_slide(velocity)
		
		if self.position.x > 50:
			self.position.x = 50
		if self.position.x < -27:
			self.position.x = -27
		if self.position.y > 33:
			self.position.y = 33
		if self.position.y < -23:
			self.position.y = -23

