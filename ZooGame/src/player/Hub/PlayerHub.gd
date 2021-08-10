extends Spatial


onready var lightButton :Area = $lightButton



func _ready() -> void:
	var de :Environment= load("res://default_env.tres")
#	de.ambient_light_energy = 0
	lightButton.connect("toggleLight",self,"toggleLight")


func toggleLight(state:bool) -> void:
	if state:
		$SpotLight.light_energy = 1.0
		$SpotLight2.light_energy = 1.0
		$Hub/Light/lightSource.visible = true
		$Hub/Light2/lightSource.visible = true
	else:
		$SpotLight.light_energy = 0.01
		$SpotLight2.light_energy = 0.01
		$Hub/Light/lightSource.visible = false
		$Hub/Light2/lightSource.visible = false
		
