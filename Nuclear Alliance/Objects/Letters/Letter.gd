extends Node2D

export var Text = ""
export var Key = ""
onready var Fnt = preload("res://Objects/Letters/LetterFont.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = Text

func _physics_process(delta):
	if Input.is_action_pressed(Key):
		$Up1.play("On")
		$Label.modulate = Color("#a1e887")
	else:
		$Up1.play("Off")
		$Label.modulate = Color("#6fa470")
	if Text == "ctrl":
		Fnt.size = 6
		$Up1.scale = Vector2(1.5,.75)
		$Label.rect_scale = Vector2(1,1)
		$Label.rect_position = Vector2(-12,-10)
	else:
		Fnt.size = 3000

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
