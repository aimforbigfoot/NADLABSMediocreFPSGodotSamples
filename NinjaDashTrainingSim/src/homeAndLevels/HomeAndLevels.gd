extends Node2D
var spot := 0
var levelData := [
	["Getting Started",Color.black,Color.white],
	["Jump back do it again!", Color.white, Color.black],
	["Faster!", Color.coral      , Color.cornflower   ],
	["", Color.black      , Color.white    ],
	["", Color.black      , Color.white    ],
	["", Color.black      , Color.white    ],
	["", Color.black      , Color.white    ],
	["", Color.black      , Color.white    ],
	["", Color.black      , Color.white    ],
	["", Color.black      , Color.white    ],
	["", Color.black      , Color.white    ],
	["", Color.black      , Color.white    ],
	["", Color.black      , Color.white    ],
#	["", Color.      , Color.    ],
#	["", Color.      , Color.    ],
#	["", Color.      , Color.    ],
#	["", Color.      , Color.    ],
#	["", Color.      , Color.    ],
#	["", Color.      , Color.    ],
#	["", Color.      , Color.    ],
#	["", Color.      , Color.    ],
#	["", Color.      , Color.    ],
#	["", Color.      , Color.    ],
#	["", Color.      , Color.    ],
#	["", Color.      , Color.    ],
#	["", Color.      , Color.    ],
]

func _ready() -> void:
	sortTheLevels()
#	print(levelData[0][2])

func sortTheLevels() -> void:
	for i in $AllNodes.get_child_count():
		var level : Node2D = $AllNodes.get_children()[i]
		level.global_position.x = i*1280
		level.setStuff( str(i+1) + " " + levelData[i][0], levelData[i][1], levelData[i][2]   )

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left") and spot > 0:
		spot -= 1
		$Tween.interpolate_property($AllNodes,"global_position:x",$AllNodes.global_position.x,$AllNodes.global_position.x+1280,0.12,Tween.TRANS_QUART,Tween.EASE_IN_OUT)
		$Tween.start()
	if event.is_action_pressed("ui_right") and spot < $AllNodes.get_child_count()-1:
		spot+= 1
		$Tween.interpolate_property($AllNodes,"global_position:x",$AllNodes.global_position.x,$AllNodes.global_position.x-1280,0.12,Tween.TRANS_QUART,Tween.EASE_IN_OUT)
		$Tween.start()
