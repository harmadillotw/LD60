extends CharacterBody2D


const SPEED = 1.0

var direction : Vector2
var moving : bool
var height : float
var increase_height : bool = false

func _ready() -> void:
	set_direction(-90)
	moving = true
	height = 100
	

func _physics_process(delta: float) -> void:
	if moving:
		velocity = direction * SPEED
	if increase_height:
		height = height + 1
	move_and_slide()

func set_direction(degrees : float) -> void:
	var radians: float = deg_to_rad(degrees)
	direction = Vector2.RIGHT.rotated(radians)
	
func stop() -> void:
	moving = false
func go() -> void:
	moving = true

func start_increase_height() -> void:
	increase_height = true
func stop_increase_height() -> void:
	increase_height = false
	
func get_height() -> float:
	return height
