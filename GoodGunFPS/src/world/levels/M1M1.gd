extends Spatial

var enemyArr := [
	preload("res://src/enemy/charger/charger.tscn")
]

func _ready() -> void:
	spawnEnemies()


func spawnEnemies() -> void:
	for i in 25:
		var enemy = enemyArr[ floor( randf() * enemyArr.size()  )  ].instance()
		$enemyFolder.add_child(enemy)
		enemy.meRandPos = false
		enemy.global_transform.origin = $enemySpawnPoints.get_child( floor( randf() * $enemySpawnPoints.get_child_count()  ) ).global_transform.origin
