extends Node2D

signal anyBtnPressed


func disabledTheButtons () -> void:
	$HBoxContainer/PowerUpButton.disabled = true
	$HBoxContainer/PowerUpButton.text = "No choice this time"
	
	$HBoxContainer/PowerUpButton2.disabled = true 
	$HBoxContainer/PowerUpButton2.text = "No choice this time"


func _on_PowerUpButton_pressed() -> void:
	emit_signal("anyBtnPressed")
	pass # Replace with function body.


func _on_PowerUpButton2_pressed() -> void:
	emit_signal("anyBtnPressed")
