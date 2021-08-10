extends Area

signal toggleLight

var randFixedCountTrigger := 10
var fixedPressCount := 0
var randBrokenCountTrigger := 3
var brokenPressCount := 0
var isBroken := false
var isColliding := false
var isOn := true

func click() -> void:
	if isBroken:
		$broken.play(0)
		brokenPressCount += 1
		if randBrokenCountTrigger <= brokenPressCount:
			isBroken = false
			brokenPressCount = 0
			randBrokenCountTrigger = floor( rand_range(3,10) )
	else:
		$flick.play(0)
		isOn = !isOn
		if isOn:
			GlobalSettings.addPower(30)
		else:
			GlobalSettings.subPower(30)
			
		emit_signal("toggleLight",isOn)
		fixedPressCount += 1
		if randFixedCountTrigger <= fixedPressCount:
			isBroken = true
			fixedPressCount = 0
			randFixedCountTrigger = floor( rand_range(1,20) )


func _ready() -> void:
	connect("area_entered",self,"aenter")
	connect("area_exited",self,"aexit")
	GlobalSettings.safeLight = self

func aenter(a:Area) -> void:
	isColliding = true

func aexit(a:Area) -> void:
	isColliding = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and isColliding:
		click()

