extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		$AnimationPlayer.play("walk")
		show_floating_text("Ouch!")


func show_floating_text(msg: String) -> void:
	var label = Label.new()
	label.text = msg
	label.position = Vector2(0, -30)
	add_child(label)

	
	var tween = get_tree().create_tween()
	tween.tween_property(label, "position", label.position + Vector2(0, -40), 1.0)
	tween.tween_property(label, "modulate:a", 0.0, 1.0)
	tween.connect("finished", label.queue_free)
