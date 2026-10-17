extends CharacterBody2D


const SPEED = 5.0
const ROTATION_SPEED = 1.0

var direction : Vector2
var moving : bool
var height : float
var increase_height : bool = false
var d_rotation : int
var d_speed : float

func _ready() -> void:
	set_direction(-90)
	rotation_degrees = -90
	moving = true
	height = 100
	d_rotation = 0
	d_speed = 0
	

func _physics_process(delta: float) -> void:
	if moving:
		velocity = direction * d_speed * SPEED
		
		var rotation_direction = Input.get_axis("d_left","d_right")
		rotation += rotation_direction * ROTATION_SPEED * delta
		set_direction(rotation_degrees) 
	if increase_height:
		height = height + 1
	var collision = move_and_collide(velocity * delta)
	if collision:
		print("finished")

func _input(event):
	if event.is_action_pressed("d_right"):
		d_rotation = d_rotation + 1
	if event.is_action_pressed("d_right"):
		d_rotation = d_rotation - 1
	if event.is_action_pressed("d_stop_rotation"):
		d_rotation = 0
	if event.is_action_pressed("d_up"):
		if d_speed < 10:
			d_speed += 1
	if event.is_action_pressed("d_down"):
		if d_speed > 1:
			d_speed -= 1
	
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
func get_speed() -> float:
	return d_speed
