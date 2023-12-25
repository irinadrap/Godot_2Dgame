extends Node2D

@export var next_scene : String

func _on_door_open_animate_body_entered(body: Node2D) -> void:
	if body.name != "player":
		return
	$OpenDoor.show()

func _on_door_open_animate_body_exited(body: Node2D) -> void:
	if body.name != "player":
		return
	$OpenDoor.hide()

func _on_go_to_nextscene_body_entered(body: Node2D) -> void:
	if body.name != "player":
		return
	get_tree().change_scene_to_file(next_scene)
