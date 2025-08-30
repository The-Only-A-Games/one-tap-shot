extends AudioStreamPlayer3D


func _ready():
	connect("finished", Callable(self, "_on_finished"))
	play()

func _on_finished():
	play()   # restarts when the stream ends
