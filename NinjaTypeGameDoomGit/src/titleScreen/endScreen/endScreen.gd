extends Control

var arrOfSentences := [
	"Hey, go rightward, there is nothing left of here",
	"""
	Hi...
	Looks like you finished the game \n
	right click to move foward
	left click to see a previous text (if you want)
	""",
	"I can't imagine anyone reaching this part",
	"There is no more game left :( sorry ",
	"You might think this part is werid",
	"With the sad music and what not",
	"but the truth is, me, the developer \n didn't like this game",
	"I just didn't find it fun anymore",
	"Making stuff is cool and all",
	"but",
	"just this game, I didn't think it was fun anymore",
	"it was such a drag",
	"doing the same stuff over and over again",
	"if you want to email me or text me on discord \n that you liked this game, \n or even if you hated it \n I would really appreciate that, \n (realnadlabs@gmail.com)\n (NAD LABS#6937)\n\nor even leaving a comment on itch.io is enough ",
	"if you want to support me you could \n subscribe on youtube",
	"just youtube nad labs, I should come up",
	"with that said",
	"thank you sooooooooooooooooooooooooooooo\n much for trying this game",
	"sorry for wasting your time",
	"",
	"there is nothing left",
	"",
	"",
	"",
	"stop going rightwards",
	"",
	"lol",
	"",
	"",
	"fine did you want more backstory",
	"I just wanted to make a doom eternal clone \n because I want to play doom eteranl",
	"but I can't, I have a gt 1030",
	"I know ew",
	"so I made my own, and this was my \n horrible attempt at it",
	"that's all",
	"if someone uploads one video of this on youtube asking for more\n I would literally remake this entire game \n but make it much better",
	"but I know that would never happen",
	"ya, that's all",
	"there is nothing right of this text",
	
	
]
var numPos := 1


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		checkAndMoveText("left")
	if event.is_action_pressed("ui_right"):
		checkAndMoveText("right")


func checkAndMoveText(dir:String) -> void:
	print(numPos)
	if dir == "left":
		if numPos <= 0:
			numPos = 0
		else:
			numPos -= 1
	elif dir == "right":
		if  (numPos >= arrOfSentences.size()-2):
			numPos = arrOfSentences.size()-1
		else:
			numPos += 1
	$Label.text = arrOfSentences[numPos]
