extends KinematicBody2D

var active = false
var attachedPlayer = 0
var direction = -1
var overlappingBreak = false

func _physics_process(delta):
	if active:
		if direction == -1:
			if self.position.y < 63:
				self.position.y = lerp(self.position.y,64,0.025)
			else:
				direction = 1
		else:
			if self.position.y > 23:
				self.position.y = lerp(self.position.y,22,0.025)
			else:
				direction = -1
		if Input.is_action_just_pressed("Interact" + str(attachedPlayer)):
			if overlappingBreak == true:
				$".".Quit()
		


func _on_Area2D_area_entered(area):
	overlappingBreak = true


func _on_Area2D_area_exited(area):
	overlappingBreak = false
