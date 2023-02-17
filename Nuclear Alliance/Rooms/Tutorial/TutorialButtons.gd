extends Camera2D

var page = 1
var totalPages = 8

func _on_NextButton_pressed():
	page += 1
	self.position.x += 160
	
	
	$Buttons/BackButton.visible = true
	$Buttons/BackButton.disabled = false
	
	if page == 8:
		$Buttons/NextButton.visible = false
		$Buttons/NextButton.disabled = true
	


func _on_BackButton_pressed():
	page -= 1
	self.position.x -= 160
	
	$Buttons/NextButton.visible = true
	$Buttons/NextButton.disabled = false
	
	if page == 1:
		$Buttons/BackButton.visible = false
		$Buttons/BackButton.disabled = true


func _on_XButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Rooms/Title/Title.tscn")
