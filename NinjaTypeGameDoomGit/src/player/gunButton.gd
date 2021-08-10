extends TextureButton

export var numOfGun := 0




func _on_gunButton_pressed() -> void:
	get_parent().doTheUnPause()
