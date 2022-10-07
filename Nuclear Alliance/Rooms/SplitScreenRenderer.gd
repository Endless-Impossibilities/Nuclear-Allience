extends CanvasLayer


##DON'T TOUCH THIS##
onready var viewport1 = $GridContainer/container1/viewport1
onready var grid = $GridContainer

func _ready():
	for i in range(1,grid.get_child_count() + 1):
		var view : Viewport = get_node("GridContainer/container" +str(i) + "/viewport" +str(i))
		if(view != null):
			var zoomSize = (grid.get_child_count() +1) / 2
			var cam : Camera2D = view.get_node("Camera2D")
			
			view.world_2d = viewport1.world_2d
			
			cam.zoom = Vector2(zoomSize,zoomSize)
			cam.global_position = viewport1.get_node("Main Room/Player" + str(i)).global_position
			
			
	pass
