extends KinematicBody2D

var active = false
var attachedPlayer = 0
var direction = -1
var overlappingBreak = false
var Velocity = Vector2(0,0)
var Collider


func _physics_process(delta):
	if active:
		if direction == -1:
			if self.position.y < 58:
				Velocity.y = lerp(Velocity.y,1,0.05)
			else:
				direction = 1
		else:
			if self.position.y > 17:
				Velocity.y = lerp(Velocity.y,-1,0.05)
			else:
				direction = -1
		if Input.is_action_just_pressed("Interact" + str(attachedPlayer)):
			if overlappingBreak == true:
				$"..".Quit(Collider.position.x,Collider.position.y)
				self.position = Vector2(2,17)
				Collider.Return()
				
		move_and_collide(Velocity)
		


func _on_Area2D_area_entered(area):
	overlappingBreak = true
	Collider = area.get_parent()


func _on_Area2D_area_exited(area):
	overlappingBreak = false
	Collider = 0
