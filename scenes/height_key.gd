extends Node2D

var scene = preload("res://scenes/h_key.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var vb_container = get_node("Panel/VBoxContainer")
	for i in range (Global.color_height.size()-1,-1,-1):
		var instance = scene.instantiate()
		var level = Global.CONTOUR_GAP * Global.CONTOUR_MULT * i 
		instance.set_values(Global.color_height[i], str(level) +"m")
		vb_container.add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
