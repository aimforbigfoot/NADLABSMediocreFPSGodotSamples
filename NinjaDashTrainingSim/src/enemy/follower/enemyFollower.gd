extends KinematicBody


var player  : KinematicBody

func _ready() -> void:
	player = get_parent().get_parent().get_node("ninjaPlayer")


func _physics_process(delta: float) -> void:
	var vel := ( player.global_transform.origin - global_transform.origin ).normalized() * 20
	vel = move_and_slide(vel)
