extends KinematicBody2D

var active = false
var attachedPlayer = 0
var PreviousX = 0
var PreviousY = 0
var Soddering = false
var Fixing = false
var breakFixing = Node2D
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	
	
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
			
			if Input.is_action_pressed("Interact1"):
				Soddering = true
				$CPUParticles2D.emitting = true
			else:
				Soddering = false
				$CPUParticles2D.emitting = false
	
		if (attachedPlayer == 2):
			if Input.is_action_pressed("Left2"):
				self.position = Vector2(self.position.x -1,self.position.y + 0)
			if Input.is_action_pressed("Right2"):
				self.position = Vector2(self.position.x +1,self.position.y + 0)
			if Input.is_action_pressed("Up2"):
				self.position = Vector2(self.position.x +0,self.position.y -1)
			if Input.is_action_pressed("Down2"):
				self.position = Vector2(self.position.x +0,self.position.y + 1)
			
			if Input.is_action_pressed("Interact2"):
				Soddering = true
				$CPUParticles2D.emitting = true
			else:
				Soddering = false
				$CPUParticles2D.emitting = false
	if Soddering == true && Fixing == true:
		breakFixing.SelfDestruct()
		$"..".Fix()
		Fixing = false
	
	if (self.position.x >= 16 or self.position.x <= -22):
		self.position.x = PreviousX
	if (self.position.y >= 26 or self.position.y <= -31):
		self.position.y = PreviousY
		



func _on_Area2D_area_entered(area):
	Fixing = true
	breakFixing = area

func _on_Area2D_area_exited(area):
	Fixing = false
