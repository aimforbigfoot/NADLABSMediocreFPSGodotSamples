extends Node

# 0 being they actually don't move maybe a little
# 100 being good luck smelly u cannot actually beat it
# 0 - 1 
var difficulity := 0.5
var player : KinematicBody
var powerAmt := 20
func addPower(amt:int) -> void:
	if powerAmt < 100:
		powerAmt += amt
	else:
		print("overload")

func subPower(amt:int) -> void:
	if powerAmt > 0:
		powerAmt -= amt
var safeLight : Area
