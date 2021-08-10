extends Node2D

var arrOfSelections := [0,0,0]

func _ready() -> void:
	print(Global.arrOfSettings)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print("got to this part go switch")
	$BodyAddonsCarousel.connect("selectedVersion",self,"bodySelected")
	$GunCarousel.connect("selectedVersion",self,"gunSelected")
	$WorldModifications.connect("selectedVersion",self,"worldSelected")
	$play.connect("pressed",self,"play")

func bodySelected(arg) -> void:
	print(arg, "body")
	setSelections(0,arg[0])
	print(arrOfSelections)
	setTheFunLabel()

func gunSelected(arg) -> void:
	print(arg,"gun selected")
	setSelections(1,arg[0])
	print(arrOfSelections)
	setTheFunLabel()


func worldSelected(arg) -> void:
	print(arg, "world selected")
	setSelections(2,arg[0])
	print(arrOfSelections)
	setTheFunLabel()


func play() -> void:
	Global.arrOfSettings = arrOfSelections
	get_tree().change_scene("res://src/world/World.tscn")


func setSelections(pos, val) -> void:
	arrOfSelections[pos] = val


func setTheFunLabel() -> void:
	var modifiedArr := []
	modifiedArr.append(arrOfSelections[0])
	modifiedArr.append(arrOfSelections[1])
	match modifiedArr:
		[0,0]:
			setFunLabel("The regular")
		[0,1]:
			setFunLabel("Double Barrel Justice")
		[0,2]:
			setFunLabel("Head Turner")
		[0,3]:
			setFunLabel("The new and old")
		[0,4]:
			setFunLabel("Sci-Fi Bananza ")
		[0,5]:
			setFunLabel("Hunter")
		[0,6]:
			setFunLabel("An Old Explosive")
		[0,7]:
			setFunLabel("Orbo")
		[0,8]:
			setFunLabel("Old Plasma")
		[0,9]:
			setFunLabel("Just my Hat")

		[1,0]:
			setFunLabel("Springa")
		[1,1]:
			setFunLabel("Rocket Shots")
		[1,2]:
			setFunLabel("Mega Rocket")
		[1,3]:
			setFunLabel("Laser Boosters")
		[1,4]:
			setFunLabel("Laserama")
		[1,5]:
			setFunLabel("A Sniping Rocket")
		[1,6]:
			setFunLabel("Kapow")
		[1,7]:
			setFunLabel("Rallo")
		[1,8]:
			setFunLabel("Rlasma")
		[1,9]:
			setFunLabel("I just need my rockets")

		[2,0]:
			setFunLabel("Springa")
		[2,1]:
			setFunLabel("")
		[2,2]:
			setFunLabel("")
		[2,3]:
			setFunLabel("")
		[2,4]:
			setFunLabel("")
		[2,5]:
			setFunLabel("")
		[2,6]:
			setFunLabel("")
		[2,7]:
			setFunLabel("")
		[2,8]:
			setFunLabel("")
		[2,9]:
			setFunLabel("")
		[2,10]:
			setFunLabel("")

		[2,0]:
			setFunLabel("Springa")
		[2,1]:
			setFunLabel("")
		[2,2]:
			setFunLabel("")
		[2,3]:
			setFunLabel("")
		[2,4]:
			setFunLabel("")
		[2,5]:
			setFunLabel("")
		[2,6]:
			setFunLabel("")
		[2,7]:
			setFunLabel("")
		[2,8]:
			setFunLabel("")
		[2,9]:
			setFunLabel("")
		[2,10]:
			setFunLabel("")

		[3,0]:
			setFunLabel("1970 attire")
		[4,0]:
			setFunLabel("An old plane")
		[5,0]:
			setFunLabel("Vroom Pew Pew")
		[6,0]:
			setFunLabel("weP weP")
		[7,0]:
			setFunLabel("Pistol Flipper")





func setFunLabel(string:String) -> void:
	$funLabel.text = string
	pass

























