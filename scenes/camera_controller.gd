extends Camera2D

@export var character : CharacterBody2D
@export var camera_offset : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = character.position
