extends Area

var color := ""
var dir := Vector3.ZERO


func _ready() -> void:
	connect("body_entered",self,"bodyEnteredBullet")
	connect("area_entered",self,"areaEnteredBullet")
	$bulletDespawn.connect("timeout",self,"bulletDespawn")
	$exploisonEffects.emitAtStart = false
#	print(color)
	if color:
		$MeshInstance.material_override = load("res://assets/materials/colorMaterials/"+color+".tres")
		$exploisonEffects.material_override = load("res://assets/materials/colorMaterials/"+color+".tres")
func _physics_process(delta: float) -> void:
	global_transform.origin += dir
#	bulletDie()5

func areaEnteredBullet(area:Area) -> void:
	if area.is_in_group("enemy"):
		area.hit(color)
		bulletDie()
	elif area.is_in_group("player"):
		pass
	elif area.is_in_group("explodeable"):
		bulletDie()
	else:
		bulletDie()
	pass


func bodyEnteredBullet(body : PhysicsBody) -> void:
	if body.is_in_group("player")  :
		pass
	elif body.is_in_group("explodeable"):
#		print(body.get_groups())
		bulletDie()


func bulletDespawn() -> void:
	print("despaned")
	bulletDie()


func bulletDie() -> void:
	dir = Vector3.ZERO
	$MeshInstance.hide()
	$exploisonEffects.myStart()
	$CollisionShape.disabled = true
	
	pass


func _on_exploisonEffects_finishedParticles() -> void:
	queue_free()
