extends CanvasModulate


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rgb = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _lights(flashing):
	self.color.r8 = flashing / 2 + rgb
	self.color.g8 = flashing / 2 + rgb
	self.color.b8 = flashing / 2 + rgb

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
