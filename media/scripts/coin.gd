extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		var gm = get_node_or_null("/root/GameManager")
		if gm:
			gm.add_coin()
		else:
			print("GameManager introuvable !")

		if has_node("CoinSound"):
			var sound = $CoinSound
			remove_child(sound)
			get_tree().get_root().add_child(sound)
			sound.play()
		else:
			print("CoinSound introuvable !")

		queue_free()
		
		
