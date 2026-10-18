extends Panel

@export var title_label : Label
@export var details_label : Label

func setup_panel(end_type : bool, time_elapsed : float) -> void:
	if end_type:
		title_label.text = "Arrived"
		details_label.text = "Time taken, " + str(time_elapsed) + " seconds"
	else:
		title_label.text = "Crashed"
		details_label.text = "Try again"


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_scene.tscn")
