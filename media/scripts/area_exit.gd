extends Area2D
class_name AreaExit

@export var sprite : Sprite2D

var is_open = false

func _ready():
	close()

func open():
	is_open = true
	sprite.regin_rect.position.x = 21

func close():
	is_open = false
	sprite.regin_rect.position.x = -1

func _on_body_entered(body: Node2D) -> void:
	if is_open && body is PlayerController:
		Gamemanager.nextlevel()
