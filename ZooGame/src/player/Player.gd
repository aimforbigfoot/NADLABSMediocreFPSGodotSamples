extends KinematicBody

var headTarget := Vector3.UP
var headDownSpeed := 0.1
var speed := 10.0
var mouseSens := 0.003
onready var ray := $head/Camera/RayCast

func _ready() -> void:
	GlobalSettings.player = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		$head.rotation.y -= event.relative.x * mouseSens
		$head/Camera.rotation.x -= event.relative.y * mouseSens
	if Input.is_action_pressed("ctrl"):
		headTarget = Vector3(0,-0.5,0)
		headDownSpeed = 0.2
	else:
		headTarget = Vector3.UP
		headDownSpeed = 0.03
	if Input.is_action_just_pressed("click"):
		if ray.is_colliding():
			var obj = ray.get_collider()
			if obj.has_method("click"):
				obj.click()
				pass
	if event.is_action_pressed("r"):
		get_tree().reload_current_scene()

func get_dir() -> Vector3:
	return Vector3( Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),0,Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")  )

func _physics_process(delta: float) -> void:
	var vel := get_dir().rotated(Vector3.UP, $head.rotation.y) * speed
	vel = move_and_slide(vel,Vector3.UP)

	$head.transform.origin = lerp( $head.transform.origin, headTarget, headDownSpeed  )
