extends KinematicBody

var isFlyingType := false 
var canJump := true
var dir := Vector3.ZERO
var speed := rand_range(25,75)
var currDir := Vector3.ZERO
var lookAtDir := true
var gravitMulti := 10
var dead := false

func _ready() -> void:
	$meshFolder/meshAnimPlayer.playback_speed = rand_range(0.5,1.5)
	if isFlyingType:
		global_transform.origin.y = rand_range(20,35)
	else:
		global_transform.origin.y = 0
	$timerFolder/oneSecondTimer.wait_time = rand_range(0.25,1.5)
	$timerFolder/tenSecDeath.connect("timeout",self,"checkForDeath")
	$timerFolder/noisePlayerTimer.connect("timeout",self,"noisePlayerGo")
	$timerFolder/noisePlayerTimer.wait_time = rand_range(10,270)
	$timerFolder/noisePlayerTimer.start()
	setStream()
#x and z pos in the world script b.c it depends on world size

func setStream() -> void:
	if randf() < 0.5:
		var arrOfMonsterNoises := [
		load("res://assets/sfx/monsterNoises/monsterNoiseDefault/monsterNoise1.wav"),
		load("res://assets/sfx/monsterNoises/monsterNoiseDefault/monsterNoise2.wav"),
		load("res://assets/sfx/monsterNoises/monsterNoiseDefault/monsterNoise3.wav"),
		load("res://assets/sfx/monsterNoises/monsterNoiseDefault/monsterNoise4.wav"),
		load("res://assets/sfx/monsterNoises/monsterNoiseDefault/monsterNoise5.wav"),
		load("res://assets/sfx/monsterNoises/monsterNoiseDefault/monsterNoise6.wav"),
		load("res://assets/sfx/monsterNoises/monsterNoiseDefault/monsterNoise7.wav"),
		load("res://assets/sfx/monsterNoises/monsterNoiseDefault/monsterNoise8.wav"),
		]
		$noisePlayerFolder/noisePlayer.stream = arrOfMonsterNoises[ floor( arrOfMonsterNoises.size() * randf() )  ]


func noisePlayerGo() -> void:
	$noisePlayerFolder/noisePlayer.play()
	pass


func updateMesh(thingToUpdateWith:SpatialMaterial) -> void:
	for mesh in $meshFolder.get_children():
		if mesh is MeshInstance and not mesh.is_in_group("no"):
			mesh.material_override = thingToUpdateWith

func _physics_process(delta: float) -> void:
	if currDir and lookAtDir:
		$orbiter/lookAtPos.global_transform.origin = lerp($orbiter/lookAtPos.global_transform.origin , -(global_transform.origin + currDir*10), 0.1  )
	$meshFolder.look_at(-Global.player.global_transform.origin, Vector3.UP)
	$RayCast.look_at(Global.player.global_transform.origin, Vector3.UP)
#	$orbiter/lookAtPos.rotation.y = (Vector2.ZERO.angle_to_point(Vector2( dir.x,dir.z  ))  )
	if not dead:
		currDir = lerp(currDir,dir, 0.1)
		currDir = move_and_slide(currDir, Vector3.UP)
	if !is_on_floor() and not isFlyingType:
		dir.y = Global.gravity*gravitMulti
	if $RayCast.is_colliding():
		if $RayCast.get_collider().is_in_group("obstacle") and canJump:
			jump()

func jump() -> void:
	if is_on_floor():
		dir.y = 400

func checkForDeath() -> void:
	if (Global.player.global_transform.origin - global_transform.origin).length() > 500:
		queue_free()



func die() -> void:
	if not dead:
		dead = true
		$timerFolder/oneSecondTimer.stop()
#		dir = Vector3.ZERO
#		currDir = Vector3.ZERO
		$dieParticles.emitting = true
		$CollisionShape.queue_free()
		$timerFolder/dieTimer.connect("timeout",self,"realDie")
		$timerFolder/dieTimer.start()
		$meshFolder.hide()
	


func realDie() -> void:
	queue_free()

