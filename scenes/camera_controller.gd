extends Camera2D

@export var character : CharacterBody2D
@export var camera_offset : Vector2

var max_zoom = 0.3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = character.position

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		zoom = zoom * 1.1
		if zoom.x > 1.0:
			zoom = Vector2(1.0,1.0)
	if event.is_action_pressed("zoom_out"):
		zoom = zoom * 0.9
	if zoom.x < max_zoom:
		zoom = Vector2(max_zoom,max_zoom)
