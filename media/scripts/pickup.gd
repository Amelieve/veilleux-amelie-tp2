extends Area2D

@onready var sound_player = $SoundPlayer

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		sound_player.play() 
		queue_free()        
