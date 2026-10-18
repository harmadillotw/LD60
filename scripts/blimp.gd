extends CharacterBody2D

@export var prop : AnimatedSprite2D
const SPEED = 5.0
const ROTATION_SPEED = 0.3

var direction : Vector2
var moving : bool
var height : float
var increase_height : bool = false
var d_rotation : int
var d_speed : float
var d_boyancy : float
var rotation_direction : float
var wind_speed : float
var wind_direction : Vector2

func _ready() -> void:
	wind_direction = Vector2(0,0)
	wind_speed = 0.0
	set_direction(-90)
	rotation_degrees = -90
	moving = true
	height = Global.map_configs[Global.current_map].start_height
	d_rotation = 0
	d_speed = 0
	d_boyancy = 0
	

func _physics_process(delta: float) -> void:
	if moving:
		var d_velocity = direction * d_speed * SPEED
		var w_velocity = wind_direction * wind_speed 
		velocity = d_velocity + w_velocity
		#var rotation_direction = Input.get_axis("d_left","d_right")
		rotation += rotation_direction * ROTATION_SPEED * delta
		set_direction(rotation_degrees) 
		height += d_boyancy * delta
	
		var collision = move_and_collide(velocity * delta)
		if collision:
			moving = false
			GlobalSignals.reached_destination.emit()

func _input(event):
	if event.is_action_pressed("d_right"):
		rotation_direction = 1
	if event.is_action_pressed("d_left"):
		rotation_direction = -1
	if event.is_action_pressed("d_stop_rotation"):
		rotation_direction = 0
	if event.is_action_pressed("d_accelerate"):
		increase_speed()
	if event.is_action_pressed("d_decelerate"):
		decrease_speed()
	if event.is_action_pressed("d_up"):
		increase_buoyancy()
	if event.is_action_pressed("d_down"):
		decrease_buoyancy()
	
func set_direction(degrees : float) -> void:
	var radians: float = deg_to_rad(degrees)
	direction = Vector2.RIGHT.rotated(radians)
	
func stop() -> void:
	moving = false
func go() -> void:
	moving = true

func start_increase_height() -> void:
	d_boyancy += 1
func stop_increase_height() -> void:
	d_boyancy -= 1
func right_rudder() -> void:
	rotation_direction = 1
func left_rudder() -> void:
	rotation_direction = -1
func stop_rudder() -> void:
	rotation_direction = 0
func get_height() -> float:
	return height
func get_speed() -> float:
	return d_speed
func get_b_rotation() -> float:
	return rotation_direction
	
func increase_speed() -> void:
	if d_speed < 1:
		prop.play()
	if d_speed < 10:
		d_speed += 1
	update_prop_speed()

func decrease_speed() -> void:
	if d_speed > 0:
		d_speed -= 1
	if d_speed < 1:
		prop.pause()
	update_prop_speed()

func update_prop_speed() -> void:
	var  d_fps = 5 + d_speed
	prop.sprite_frames.set_animation_speed("default", d_fps)
	
func increase_buoyancy() -> void:
	if d_boyancy < 10:
		d_boyancy += 1
func decrease_buoyancy() -> void:
	if d_boyancy > -10:
		d_boyancy -= 1
func get_buoyancy() -> float:
	return d_boyancy
	
func set_wind(wdir : Vector2, wspeed : float) -> void:
	wind_direction = wdir
	wind_speed = wspeed 
	
	
