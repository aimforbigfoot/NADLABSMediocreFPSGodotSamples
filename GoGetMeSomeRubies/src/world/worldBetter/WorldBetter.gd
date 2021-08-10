extends Spatial

var minMar := 50
var maxMar := 150
onready var player := $theSlayer

func _ready() -> void:
	randomize()
	$ruby.connect("body_entered",self,"rubyGone")
	$spawnBlocks.connect("timeout",self,"spawnBlocks")

func rubyGone(body:PhysicsBody) -> void:
	if body:
		$ruby.queue_free()
		$floor.queue_free()
		spawnBlocks(1)
		

func spawnBlocks(randVal : float = 0.2) -> void:
	if randVal > randf():
		for i in 10:
			var block :Spatial= preload("res://src/world/grabPost/goldPost.tscn").instance()
			$blockFolder.add_child(block)
			var randVec := Vector3(
				rand_range(-maxMar+player.global_transform.origin.x,-minMar+player.global_transform.origin.x) if randf() < 0.5 else rand_range(minMar+player.global_transform.origin.x, maxMar+player.global_transform.origin.x),
				rand_range(-maxMar+player.global_transform.origin.y,-minMar+player.global_transform.origin.y) if randf() < 0.5 else rand_range(minMar+player.global_transform.origin.y, maxMar+player.global_transform.origin.y),
				rand_range(-maxMar+player.global_transform.origin.z,-minMar+player.global_transform.origin.z) if randf() < 0.5 else rand_range(minMar+player.global_transform.origin.z, maxMar+player.global_transform.origin.z)
			)
			block.global_transform.origin = randVec
		$spawnBlocks.start()
