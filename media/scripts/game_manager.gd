extends Node

# Dossier contenant tes scenes area_1.tscn, area_2.tscn, ...
var area_path_prefix : String = "res://areas/"

var current_area : int = 1
var coin : int = 0

var area_container : Node2D
var player   # PlayerController si tu as class_name, sinon gardé non typé
var hud      # optionnel si tu as un HUD

func _ready() -> void:
	area_container = get_tree().get_first_node_in_group("area_container")
	if not area_container:
		push_warning("area_container introuvable (groupe 'area_container').")
	player = get_tree().get_first_node_in_group("player")
	if not player:
		push_warning("player introuvable (groupe 'player').")
	hud = get_tree().get_first_node_in_group("hud")
	# charge l'aire de départ
	load_area(current_area)
	reset_coin()


func next_level() -> void:
	current_area += 1
	load_area(current_area)


func load_area(area_number: int) -> void:
	# construit le chemin correctement
	var full_path = area_path_prefix + "area_" + str(area_number) + ".tscn"
	print("Loading area:", full_path)

	var scene : PackedScene = load(full_path) as PackedScene
	if not scene:
		push_error("Impossible de charger la scène : " + full_path)
		return

	# vide proprement le container
	if area_container:
		for child in area_container.get_children():
			child.queue_free()
			await child.tree_exited
	else:
		push_error("area_container est null; impossible d'instancier l'area.")
		return

	# instancie la nouvelle area
	var instance = scene.instantiate()
	area_container.add_child(instance)

	# attends un frame pour que les nodes s'initialisent correctement
	await get_tree().idle_frame

	# reset des pièces / UI
	reset_coin()


func add_coin() -> void:
	coin += 1
	if hud and hud.has_method("update_coin_label"):
		hud.update_coin_label(coin)

	if coin >= 4:
		# recherche les portals par groupe
		var portals = get_tree().get_nodes_in_group("area_exits")
		if portals.size() == 0 and area_container:
			for a in area_container.get_children():
				if a.has_node("Portal"):
					portals.append(a.get_node("Portal"))
		if portals.size() > 0:
			for p in portals:
				if p and p.has_method("open"):
					p.open()
				else:
					push_warning("Portal trouvé mais sans méthode open(): " + str(p))
			if hud and hud.has_method("portal_opened"):
				hud.portal_opened()
		else:
			push_warning("Aucun portail trouvé lors de add_coin().")


func reset_coin() -> void:
	coin = 0
	if hud and hud.has_method("update_coin_label"):
		hud.update_coin_label(coin)
		hud.portal_closed()
