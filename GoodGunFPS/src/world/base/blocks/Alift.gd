extends Spatial

var canShoot := true

func _ready() -> void:
	$checkArea.connect("area_entered",self,"areaEntered")
	$Tween.connect("tween_all_completed",self,"td")

func td() -> void:
	if not canShoot:
		$Tween.interpolate_property($lift, "global_transform:origin:y", 0, -94, 20,Tween.TRANS_EXPO,Tween.EASE_OUT )
		$Tween.start()
	canShoot = true

func areaEntered(area:Area) -> void:
	if area.is_in_group("playerBullet") and canShoot:
		canShoot = false
		$Tween.interpolate_property($lift, "global_transform:origin:y", -94, 0, 10,Tween.TRANS_EXPO,Tween.EASE_OUT )
		$Tween.start()
		pass
