extends Area2D

@onready var sound_player = $SoundPlayer

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		GameManager.add_coin()
		queue_free()        
