extends Spatial

var listOfSounds := [
	load("res://assets/sfx/ambeince/scaryAmbience1.wav"),
	load("res://assets/sfx/ambeince/otherAmbience2.wav")
]

func playRandomSound() -> void:
	$AudioStreamPlayer3D.stream = listOfSounds[ floor( listOfSounds.size() * randf() )  ]
	$AudioStreamPlayer3D.play()

func _ready() -> void:
	playRandomSound()

func _on_AudioStreamPlayer3D_finished() -> void:
	playRandomSound()
