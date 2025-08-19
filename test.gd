extends Node2D

var idk :Dictionary = {1: "i", 55: "num"}

func _ready() -> void:
	if idk.values().has("i"):
		print("yes")
		print("test test test")
		print("can i return to my old verison???")
