extends "res://src/enemy/enemyBase.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isFlying = true
	global_transform.origin.y = rand_range(100,500)
	var mat = $MeshInstance.get_surface_material(0)
	mat.set_shader_param("primary_color", Global.colorChosen)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
