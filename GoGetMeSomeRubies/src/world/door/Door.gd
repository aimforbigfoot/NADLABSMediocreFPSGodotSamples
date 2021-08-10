extends Spatial

var nextPlaceCol := false
var player : KinematicBody

func _ready() -> void:
	player = get_parent().get_node("theSlayer")
	player.connect("gotRubySignal",self,"startPortal")
	$Area.connect("body_entered",self,"bodyEnterd")
	$MeshInstance2.hide()

func bodyEnterd(body) -> void:
	if body.is_in_group("player") and nextPlaceCol:
		Global.rubiesCollected += 1
		Global.chanceOfErrorNoise = 0.0
		get_tree().reload_current_scene()

func startPortal() -> void:
	$MeshInstance2.show()
	nextPlaceCol = true
	print("starting portal")
	

