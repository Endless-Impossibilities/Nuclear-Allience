extends TextureButton
export var destination = ""



func _on_Play_pressed():
	get_tree().change_scene(destination)
