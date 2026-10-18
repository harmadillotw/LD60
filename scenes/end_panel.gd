extends Panel

@export var title_label : Label
@export var details_label : Label

# endtype
# 0 = success
# 1 = crash
# 2 = out of bounds

func setup_panel(end_type : int, time_elapsed : float) -> void:
	if end_type == 0:
		title_label.text = "Arrived"
		details_label.text = "Time taken, " + str(time_elapsed) + " seconds"
	elif end_type == 1:
		title_label.text = "Crashed"
		details_label.text = "Try again"
	elif end_type == 2:
		title_label.text = "Out Of Bounds"
		details_label.text = "Try again"
	else :
		title_label.text = "Something went wrong"
		details_label.text = "Try again"


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_scene.tscn")
