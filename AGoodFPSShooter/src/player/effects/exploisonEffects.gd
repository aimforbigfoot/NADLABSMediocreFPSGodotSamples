extends Particles

signal finishedParticles
export var emitAtStart := true

func _ready() -> void:
	$Timer.connect("timeout",self,"die")
	if emitAtStart:
		myStart()

func die() -> void:
	queue_free()
	emit_signal("finishedParticles")
#	print("emitedSignal")

func myStart() -> void:
	emitting = true
	$Timer.start()
