extends Area


func _ready() -> void:
	connect("body_entered",self,"bodyEntered")

func bodyEntered(body:PhysicsBody)  -> void:
	if body.is_in_group("player"):
		body.rubyGot()
		$AudioStreamPlayer3D.play()
		$MeshInstance.hide()
		$CollisionShape.disabled = true
		$Particles.emitting = false
		$OmniLight.hide()
		$OmniLight2.hide()
