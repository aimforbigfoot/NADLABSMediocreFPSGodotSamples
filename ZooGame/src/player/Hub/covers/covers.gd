extends Area

onready var barr := $H/barrier
var isColliding = false
var isOpen := false
const topMarg := 13.00
const bottomMarg := 10.00
var isTryingToBeOpened := false
var difficultyAmt := 2.0
var isDragging := false

func click() -> void:
	pass

func _ready() -> void:
	visible = true
	connect("area_entered",self,"aenter")
	connect("area_exited",self,"aexit")
	$openingTimer.connect("timeout",self,"openingTimer")

func aenter(a:Area) -> void:
	isColliding = true
	difficultyAmt = difficultyAmt * 2.0

func aexit(a:Area) -> void:
	isColliding = false
	difficultyAmt = difficultyAmt / 2.0

func _input(event: InputEvent) -> void:
	if isDragging:
		$draggingPlayer.play(rand_range(0,5))
	else:
		$draggingPlayer.stop()
	if isColliding and Input.is_action_pressed("click") and event is InputEventMouseMotion:
		var diff :float= event.relative.y * 0.002
		if ((barr.global_transform.origin.y - diff*2) > bottomMarg and (barr.global_transform.origin.y- diff*2) < topMarg):
			barr.global_transform.origin.y -= diff
		if barr.global_transform.origin.y <= 10.01:
			barr.global_transform.origin.y = 10.01
		if barr.global_transform.origin.y >= 12.98:
			barr.global_transform.origin.y = 12.98
		isDragging = true
	else:
		isDragging = false
	if event.is_action_pressed("t") and isColliding:
		isTryingToBeOpened = true
		print("trying")
		openingTimer()

func openingTimer() -> void:
	if randf() < 0.01:
		isTryingToBeOpened = false
		isDragging = false
		print("stopped trying to be opened")
	if isTryingToBeOpened:
		isDragging = true
		barr.global_transform.origin.y += rand_range(-0.001,0.02)*difficultyAmt
		$openingTimer.start(rand_range(0.01,0.05))
