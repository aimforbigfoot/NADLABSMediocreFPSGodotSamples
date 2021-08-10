extends Node2D

func _ready() -> void:
	$hurtTween.connect("tween_all_completed",self,"returnNormalHurt")

func splashWithGoop() -> void:
	$AnimationPlayer.play("goop")

func setHP(num:float) -> void:
	$HUD/hpLabel.text = ("HP: " + str(num))


func setAmmo(num:int) -> void:
	$HUD/ammoLabel.text = ("AMMO: " + str(num) )


func hurt(amt:float,newHealth:float) -> void:
	setHP(newHealth)
	$hurtTween.interpolate_property($ColorRect,"color", Color(0,0,0,0), Color(amt/7,0,0,amt/10/4), 0.5,Tween.TRANS_BACK,Tween.EASE_OUT )
	$hurtTween.start()


func returnNormalHurt() -> void:
	$returnHurtTween.interpolate_property($ColorRect,"color",$ColorRect.color, Color(0,0,0,0), 0.2, Tween.TRANS_QUART,Tween.EASE_IN)
	$returnHurtTween.start()
