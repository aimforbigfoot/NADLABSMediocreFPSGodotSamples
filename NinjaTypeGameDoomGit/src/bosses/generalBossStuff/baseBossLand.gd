extends Spatial

onready var finishLevel := $finishLevel
onready var musicPlayer := $musicPlayer
onready var boss 
onready var player := $player
var doneLevel := false 
var didPlayerDie := false 

func _ready() -> void:
	randomize()
	Global.randomiez_the_meshes()
	if Global.musicAllowed:
		musicPlayer.stream = Global.songsArr[ floor(Global.songsArr.size() * randf()  ) ]
		musicPlayer.play()
	var procSky := ProceduralSky.new()
	procSky.sky_top_color= Color(randf(),randf(),randf(),1  )
	procSky.sky_horizon_color = Color(randf(),randf(),randf(),1  )
	procSky.ground_horizon_color = Color(randf(),randf(),randf(),1  )
	procSky.ground_bottom_color = Color.black
	procSky.sun_color = Color(randf(),randf(),randf(),1  )
	var de : = load("res://default_env.tres")
	de.background_sky = procSky


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("r") && didPlayerDie:
		get_tree().reload_current_scene()
	if event.is_action_pressed("q") && didPlayerDie:
		get_tree().change_scene("res://src/titleScreen/TitleScreen.tscn")


func _on_OneSecondChecker_timeout() -> void:
	if player.global_transform.origin.y < -100 and !didPlayerDie:
		player.die("dienow")
	if not doneLevel and boss:
		if boss.dead:
			doneLevel = true 
			finishLevel.play()
			var portal :Area= preload("res://src/pickup/portal.tscn").instance()
			add_child(portal)
			portal.global_transform.origin = Vector3(150,50,150)


func _on_musicPlayer_finished() -> void:
	musicPlayer.stream = Global.songsArr[ floor(Global.songsArr.size() * randf()  ) ]
	musicPlayer.play()
