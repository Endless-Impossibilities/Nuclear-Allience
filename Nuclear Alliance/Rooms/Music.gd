extends AudioStreamPlayer

var blackout = false
var masterVolume = 0

func _physics_process(delta):
	if blackout:
		self.volume_db -= 0.1
		masterVolume -= 0.09
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),masterVolume)


func _on_AudioStreamPlayer_finished():
	self.play(41)

func blackout():
	blackout = true
