extends Panel

@export var sprite : Sprite2D
@export var label : Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_values(color_val : String, k_label : String) -> void:
	label.text = k_label
	sprite.modulate = Color(color_val)
	
