extends Sprite

var fluxDirection = "Down"

func _physics_process(delta):
	if fluxDirection == "Up":
		self_modulate.a8 += 1
	elif fluxDirection == "Down":
		self_modulate.a8 -= 1
		
	get_tree().call_group("Lighting","_lights",self_modulate.a8)
		
		
	if self_modulate.a8 >= 200:
		fluxDirection = "Down"
	if self_modulate.a8 <= 30:
		fluxDirection = "Up"
	
