extends Node

var current_area = 1
var area_path = "res://media"

var coin = 0

func next_level():
	current_area += 1
	var full_path = area_path + "area" + str(current_area) + ".tscn"
	get_tree().change_scene_to_file(full_path)
	
func set_up_area():
	reset_coin()

func add_coin():
	coin += 1
	if coin >= 4:
		var portal = get_tree().get_first_node_in_group("area_exits") as AreaExit
		portal.open()

func reset_coin():
	coin = 0
