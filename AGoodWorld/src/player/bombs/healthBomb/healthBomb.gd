extends RigidBody

func _ready() -> void:
	$converterArea.connect("body_entered",self,"bodyEntered")

func bodyEntered(body) -> void:
	if body.is_in_group("enemy"):
		body.updateMesh(load("res://assets/materials/bloody.tres"))
