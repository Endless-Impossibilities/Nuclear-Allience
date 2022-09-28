extends KinematicBody2D

var active = false
var attachedPlayer = 0
var PreviousX = 0
var PreviousY = 0
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	print(attachedPlayer)
	print(active)
	
	PreviousX = self.position.x
	PreviousY = self.position.y
	
	if (active == true):
		if (attachedPlayer == 1):
			if Input.is_action_pressed("Left1"):
				self.position = Vector2(self.position.x -1,self.position.y + 0)
			if Input.is_action_pressed("Right1"):
				self.position = Vector2(self.position.x +1,self.position.y + 0)
			if Input.is_action_pressed("Up1"):
				self.position = Vector2(self.position.x +0,self.position.y -1)
			if Input.is_action_pressed("Down1"):
				self.position = Vector2(self.position.x +0,self.position.y + 1)
		if (attachedPlayer == 2):
			if Input.is_action_pressed("Left2"):
				self.position = Vector2(self.position.x -1,self.position.y + 0)
			if Input.is_action_pressed("Right2"):
				self.position = Vector2(self.position.x +1,self.position.y + 0)
			if Input.is_action_pressed("Up2"):
				self.position = Vector2(self.position.x +0,self.position.y -1)
			if Input.is_action_pressed("Down2"):
				self.position = Vector2(self.position.x +0,self.position.y + 1)
	
	
	if (self.position.x >= 26 or self.position.x <= -33):
		self.position.x = PreviousX
	if (self.position.y >= 26 or self.position.y <= -31):
		self.position.y = PreviousY
