extends Node
var current_area = 1
var area_path = "res://area_exit.tsn"

func next_level():
	current_area +=1
	var full_path = area_path + "area_" + str(current_area) +".tscn"
	get_tree().change_scene_to_file("res://area_02.tscn")
	str(current_area)
