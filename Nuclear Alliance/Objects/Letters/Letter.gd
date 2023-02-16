extends Node2D

# The text in the text box
export var Text = ""

# The associated key
export var Key = ""

#The font
onready var Fnt = preload("res://Objects/Letters/LetterFont.tres")

### Gets the text to display ###
func _ready():
	$Label.text = Text

### Code run on a every frame basis ###
func _physics_process(delta):

## Tells the icon to light up on keypress ##
	if Input.is_action_pressed(Key):
		$Up1.play("On")
		$Label.modulate = Color("#a1e887")
	else:
		$Up1.play("Off")
		$Label.modulate = Color("#6fa470")

## Resized the sprite for player 2 interact ##
	if "ctrl" in Text:
		$Up1.scale.x = 2
		$Up1.position = Vector2(2,-6)
		
		$Label.rect_scale = Vector2(0.5,0.5)
		$Label.rect_position = Vector2(-12,-10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
