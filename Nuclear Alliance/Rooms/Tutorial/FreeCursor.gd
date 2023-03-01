extends KinematicBody2D

var direction = -1
var Velocity = Vector2(0,0)

func _physics_process(delta):
	if direction == -1:
		if self.position.y < 120:
			Velocity.y = lerp(Velocity.y,1,0.05)
		else:
			direction = 1
	else:
		if self.position.y > 79:
			Velocity.y = lerp(Velocity.y,-1,0.05)
		else:
			direction = -1
	move_and_collide(Velocity)
