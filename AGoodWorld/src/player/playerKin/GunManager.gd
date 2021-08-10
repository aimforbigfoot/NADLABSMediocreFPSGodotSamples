extends Spatial

var canFireMachineGun := true
var macGunSpeed := 50.0

func _ready() -> void:
	$machineGunTimer.connect("timeout",self,"machineGunTimerTimeOut")


func machineGunTimerTimeOut() -> void:
	canFireMachineGun = true


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		fireMachineGun()
	if Input.is_action_just_pressed("h"):
		fireHealthBomb()
	if Input.is_action_just_pressed("c"):
		fireIceBomb()

func fireIceBomb() -> void:
	var ib : RigidBody = preload("res://src/player/bombs/iceBomb/iceBomb.tscn").instance()
	get_parent().get_parent().get_parent().get_parent().add_child(ib)
	ib.apply_central_impulse( ($machineGun/macGunPos.global_transform.origin - global_transform.origin).normalized()*50 )
	ib.global_transform.origin = $machineGun/macGunPos.global_transform.origin


func fireHealthBomb() -> void:
	var hb :RigidBody= preload("res://src/player/bombs/healthBomb/healthBomb.tscn").instance()
	get_parent().get_parent().get_parent().get_parent().add_child(hb)
	hb.apply_central_impulse(  ($machineGun/macGunPos.global_transform.origin - global_transform.origin).normalized()*50  )
	hb.global_transform.origin = $machineGun/macGunPos.global_transform.origin


func fireMachineGun() -> void:
	if canFireMachineGun:
		canFireMachineGun = false
		$machineGunTimer.start()
		var bullet :KinematicBody= preload("res://src/player/bulletKin/bulletKin.tscn").instance()
		get_parent().get_parent().get_parent().get_parent().add_child(bullet)
		bullet.dir = ( $machineGun/macGunPos.global_transform.origin - global_transform.origin  ).normalized()*3
		bullet.global_transform.origin = $machineGun/macGunPos.global_transform.origin
