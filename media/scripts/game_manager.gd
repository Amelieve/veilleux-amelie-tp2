extends Node

var current_area = 1
var area_path = "res://Assets/Scenes"

var coin = 0

func _ready():
	reset_coin()

func next_level():
	current_area += 1
	var full_path = area_path + "/area_" + str(current_area) + ".tscn"  # / ajouté
	get_tree().change_scene_to_file(full_path)
	print("Le joueur a changé de place " + str(current_area))

func set_up_area():
	reset_coin()
	
func add_coin():
	coin += 1
	if coin >= 4:
		var portal_node = get_tree().get_first_node_in_group("area_exits")  # note le pluriel
		if portal_node and portal_node is AreaExit:
			var portal = portal_node as AreaExit
			portal.open()
		else:
			print("Erreur : aucun portail trouvé ou mauvais type")
		
func reset_coin():
	coin = 0
