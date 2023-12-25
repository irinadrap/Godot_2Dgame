extends Node2D

func _on_area_2d_player_entered(body: Node2D) -> void:
	if body.name == "player":
		body.on_death()
