extends Node2D

signal macGunSpecialTrue

onready var mg := $G/macGun
onready var sniper := $G/sniper
onready var gernades := $G/gernades
onready var wind := $G/wind
onready var rockets := $G/rockets
onready var shotgun := $G/shotGun
var toGoBack := true

func _ready() -> void:
	zero()
	$HUD/ColorRect/goToColor.connect("tween_all_completed",self,"goBackToClear")

func hpSet(num) -> void:
	$HUD/HBoxContainer/hpLabel.text = ("HP: " + str(num))
func ammoSet(num) -> void:
	$HUD/HBoxContainer/ammoLabel.text = ("AMMO: "+str(num))
func setCamToColor(color,time:float=1.0) -> void:
	if time:
		$HUD/ColorRect/goToColor.interpolate_property($HUD/ColorRect,"color",$HUD/ColorRect.color, color, time,Tween.TRANS_CUBIC,Tween.EASE_IN)
		$HUD/ColorRect/goToColor.start()
		toGoBack = true
	else:
		$HUD/ColorRect/goToColor.interpolate_property($HUD/ColorRect,"color",$HUD/ColorRect.color, color, 0.5,Tween.TRANS_CUBIC,Tween.EASE_IN)
		$HUD/ColorRect/goToColor.start()
		toGoBack = false


func goBackToClear(time:float = 0.5) -> void:
	if toGoBack:
		$HUD/ColorRect/goBackToRegular.interpolate_property($HUD/ColorRect,"color",$HUD/ColorRect.color,Color(0,0,0,0),time,Tween.TRANS_CUBIC,Tween.EASE_IN)
		$HUD/ColorRect/goBackToRegular.start()


func addToMacGun() -> void:
	if $G/macGun/ProgressBar.value >= 90:
		emit_signal("macGunSpecialTrue")
		pass
	else:
		$G/macGun/ProgressBar.value += 5
func resetMacGun() -> void:
	$G/macGun/ProgressBar.value = 0
func addToShotgun() -> void:
	if $G/macGun/ProgressBar.value >= 90:
		emit_signal("macGunSpecialTrue")
		pass
	else:
		$G/shotGun/ProgressBar.value += 5
func resetShotGun() -> void:
	$G/shotGun/ProgressBar.value = 0


func sniperReset(amt) -> void:
	$G/sniper/Tween.interpolate_property($G/sniper/Sprite,"modulate",Color.black,Color.white,amt,Tween.TRANS_CUBIC,Tween.EASE_IN)
	$G/sniper/Tween.start()
func macGunReset(amt) -> void:
	$G/macGun/Tween2.interpolate_property($G/macGun/Sprite,"modulate",Color.black,Color.white,amt, Tween.TRANS_CUBIC,Tween.EASE_IN)
	$G/macGun/Tween2.start()
func gernadesReset(amt) -> void:
	$G/gernades/Tween2.interpolate_property($G/gernades/Sprite,"modulate",Color.black,Color.white,amt, Tween.TRANS_CUBIC,Tween.EASE_IN)
	$G/gernades/Tween2.start()
func windReset(amt) -> void:
	$G/wind/Tween.interpolate_property($G/wind/Sprite,"modulate",Color.black,Color.white,amt,Tween.TRANS_CUBIC,Tween.EASE_IN)
	$G/wind/Tween.start()
func rocketReset(amt) -> void:
	$G/rockets/Tween.interpolate_property($G/rockets/Sprite,"modulate",Color.black,Color.white,amt,Tween.TRANS_CUBIC,Tween.EASE_IN)
	$G/rockets/Tween.start()
func shotgunRest(amt) -> void:
	$G/shotGun/Tween.interpolate_property($G/shotGun/Sprite,"modulate",Color.black,Color.white,amt,Tween.TRANS_CUBIC,Tween.EASE_IN)
	$G/shotGun/Tween.start()

func hideAll() -> void:
	for child in $G.get_children():
		child.hide()
func zero() -> void:
	hideAll()
	mg.show()
func one() -> void:
	hideAll()
	sniper.show()
func two() -> void:
	hideAll()
	gernades.show()
func three() -> void:
	hideAll()
	wind.show()
func four() -> void:
	hideAll()
	rockets.show()
func five() -> void:
	hideAll()
	shotgun.show()
	
