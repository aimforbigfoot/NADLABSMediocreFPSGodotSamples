extends Area

export var dirToPush := Vector3.UP
export var isDisappear := false
var factorToPushWith := 1.0
var sm := SpatialMaterial.new()
var colorArr := ["red","orange","blue","green","purple"]
var color := ""

func _ready() -> void:
	color = colorArr[ floor( randf() * colorArr.size() ) ]
	setColor(isDisappear)
	print("runs")
	connect("body_entered",self,"bodyEntered")
	randomize()
	sm.flags_transparent = true
	global_transform.origin.y = rand_range(0,100)
	var r := randf() 
	var v := 0.125
#	varriedOne(r,v)
	coloredBlocksOnly(r,v)
	$dashCollidedPlayer.connect("finished",self,"doneNoise")
#	print(isDisappear)

func setArrow(x,z) -> void:
	$arrow.rotation_degrees = Vector3(x, 0 ,z)

func setColor(isDisappear)-> void:
	var mat : SpatialMaterial
	match color:
		"red":
			mat = load("res://assets/materials/colors/red.tres")
			dirToPush = Vector3.LEFT
			setArrow(0,90)
		"orange":
			mat = load("res://assets/materials/colors/orange.tres")
			setArrow(-90,0)
			dirToPush = Vector3.FORWARD
		"yellow":
			mat = load("res://assets/materials/colors/yellow.tres")
			setArrow(180,0)
			dirToPush = Vector3.DOWN/0.5
		"green":
			mat = load("res://assets/materials/colors/green.tres")
			setArrow(90,0)
			dirToPush = Vector3.BACK
		"blue":
			mat = load("res://assets/materials/colors/blue.tres")
			setArrow(0,0)
			dirToPush = Vector3.UP*1.5
		"purple":
			mat = load("res://assets/materials/colors/pruple.tres")
			setArrow(0,-90)
			dirToPush = Vector3.RIGHT
	if isDisappear:
		match color:
			"red":
				mat = load("res://assets/materials/colorGarbled/red.tres")
			"orange":
				mat = load("res://assets/materials/colorGarbled/orange.tres")
			"yellow":
				mat = load("res://assets/materials/colorGarbled/yellow.tres")
			"green":
				mat = load("res://assets/materials/colorGarbled/green.tres")
			"blue":
				mat = load("res://assets/materials/colorGarbled/blue.tres")
			"purple":
				mat = load("res://assets/materials/colorGarbled/pruple.tres")
	$MeshInstance.material_override = mat


func varriedOne(r,transVal) -> void:
	if r < 0.16:
		setCuve(1.0, Vector3.LEFT, "red", 0, 90)
	elif r < 0.32:
		setCuve(1.0,  Vector3.RIGHT, "purple", 0, -90)
	elif r < 0.48:
		setCuve(1.0, Vector3.FORWARD, "orange", -90, 0)
	elif r < 0.64:
		setCuve(1.0, Vector3.BACK, "green", 90, 0)
	elif r < 0.8:
		setCuve(1.0, Vector3.DOWN, "yellow", 180, 0)
	else:
		setCuve(1.0,Vector3.UP*1.5, "blue", 0, 0)

func coloredBlocksOnly(r,v) -> void:
	if r < 0.2:
		setCuve(0.5, Vector3.LEFT, "red", 0, 90)
	elif r < 0.4:
		setCuve(0.75,  Vector3.RIGHT, "pruple", 0, -90)
	elif r < 0.6:
		setCuve(1.0, Vector3.FORWARD, "orange", -90, 0)
	elif r < 0.8:
		setCuve(1.25 ,Vector3.BACK, "green", 90,0)
	else:
		setCuve(1.5, Vector3.UP*1.5, "blue", 0,0)

func setCuve(pitch, dir, color,xRot,zRot) -> void:
	$dashCollidedPlayer.pitch_scale = pitch

func bodyEntered(body:PhysicsBody) -> void:
	if body.is_in_group("player"):
		body.extraVel += dirToPush * 300 * factorToPushWith
		body.boxEffect()
		if isDisappear:
			$dashCollidedPlayer.pitch_scale -= 0.1
			$dashCollidedPlayer.play()
#			queue_free()
		else:
			$dashCollidedPlayer.play()
			

func doneNoise() -> void:
	if isDisappear:
		queue_free()

