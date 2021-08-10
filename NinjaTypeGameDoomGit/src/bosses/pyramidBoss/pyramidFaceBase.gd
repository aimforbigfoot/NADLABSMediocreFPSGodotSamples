extends Area

onready var phase1Orbs := $SpriteAndOrbs/Position3D/phase1Orbs
onready var phase2Orbs := $SpriteAndOrbs/Position3D/phase2Orbs
onready var phase3Orbs := $SpriteAndOrbs/Position3D/phase3Orbs
onready var animPlayer := $AnimationPlayer
onready var animSprite := $SpriteAndOrbs/Position3D/AnimatedSprite3D
var phase := 1

func _ready() -> void:
	animSprite.play("1")
	togglephase1Orbs(false)
	togglephase2Orbs(true)
	togglephase3Orbs(true)


func smash() -> void:
	animPlayer.play("smash")


func updatePhase() -> void:
	print(phase)
	if checkphase1Orbs():
		phase = 1
		return 
	elif checkphase2Orbs():
		phase = 2
		return
	elif checkphase3Orbs():
		phase = 3
		return
	else:
		phase = 4


func moveToPhase2() -> void:
	animSprite.play("2")
	phase2Orbs.visible = true
	togglephase2Orbs(false)


func moveToPhase3() -> void:
	animSprite.play("3")
	phase3Orbs.visible = true
	togglephase3Orbs(false)

func checkphase1Orbs() -> bool:
	if phase1Orbs.get_children():
		return true
	else:
		return false
func checkphase2Orbs() -> bool:
	if phase2Orbs.get_children():
		return true
	else:
		return false
func checkphase3Orbs() -> bool:
	if phase3Orbs.get_children():
		return true
	else:
		return false

func togglephase1Orbs(bol) -> void:
	for thing in phase1Orbs.get_children():
		thing.disabled = bol
		thing.visible = !bol
func togglephase2Orbs(bol) -> void:
	for thing in phase2Orbs.get_children():
		thing.visible = !bol
		thing.disabled = bol
func togglephase3Orbs(bol) -> void:
	for thing in phase3Orbs.get_children():
		thing.visible = !bol
		thing.disabled = bol

func die(strr:String="no") -> void:
	if strr !="no":
		queue_free()


func _on_accArea_body_entered(body: Node) -> void:
	if body.is_in_group("player") and body.has_method("die"):
		body.die()
