extends Node2D


func updatePower() -> void:
	$ProgressBar.value = GlobalSettings.powerAmt 
	pass

func _physics_process(delta: float) -> void:
	updatePower()
