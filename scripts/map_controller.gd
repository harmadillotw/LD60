extends Node2D

const MAX_OUT_TIME = 5.0
@export var sprite : Sprite2D
@export var destination : Node2D
@export var blimp :CharacterBody2D

@export var position_label : Label

@export var height_label : Label
@export var ground_height_label : Label
@export var speed_label : Label

@export var time_label : Label



@export var end_panel : Panel

@export var rr_button : TextureButton
@export var lr_button : TextureButton

@export var buoy_label : Label

@export var direction_sprite : Sprite2D
@export var wind_sprite : Sprite2D

@export var out_time_label : Label
@export var out_time_panel : Panel

@export var color_height : Array[Color]

var time_elapsed : float
var update_time : bool
var sprite_pos
var inbounds : bool
var outbounds_time : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.reached_destination.connect(_reached_destination)
	sprite_pos = sprite.position
	sprite.texture = Global.current_display_map
	time_elapsed = 0.0
	update_time = true
	if Global.generated_level:
		wind_sprite.rotation_degrees = Global.gen_map_config.wind_direction
		var wind_speed = Global.gen_map_config.wind_speed
		var wind_dir = Global.gen_map_config.wind_direction
		
		blimp.set_wind(rotation_to_direction(wind_dir),wind_speed)
		#blimp.set_wind(Vector2.from_angle(wind_dir),wind_speed)
		destination.position = Global.gen_map_config.destination_location
		blimp.position = Global.gen_map_config.start_loction
	else:
		#sprite.texture = ImageTexture.create_from_image(Global.current_map)
		wind_sprite.rotation_degrees = Global.map_configs[Global.current_map].wind_direction
		var wind_speed = Global.map_configs[Global.current_map].wind_speed
		var wind_dir = Global.map_configs[Global.current_map].wind_direction
		
		blimp.set_wind(rotation_to_direction(wind_dir),wind_speed)
		#blimp.set_wind(Vector2.from_angle(wind_dir),wind_speed)
		destination.position = Global.map_configs[Global.current_map].destination_location
		blimp.position = Global.map_configs[Global.current_map].start_loction
	inbounds = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	#update timers
	if update_time:
		time_elapsed += delta
	if !inbounds:
		outbounds_time += delta
		var time_diff : float = MAX_OUT_TIME - outbounds_time
		out_time_label.text = str(snappedf(time_diff,0.1))
		if outbounds_time > MAX_OUT_TIME:
			blimp.stop()
			update_time = false
			out_time_panel.visible = false
			end_panel.setup_panel(2,time_elapsed)
			end_panel.visible = true
	#check blimp position
	var blimp_pos = blimp.global_position
	# Check blimp inside map
	var inside_bounds = true
	if blimp_pos.x < 0 || blimp_pos.x > 1920:
		inside_bounds = false
	if blimp_pos.y < 0 || blimp_pos.y > 1080:
		inside_bounds = false
	if inside_bounds:
		if !inbounds:
			inbounds = true
			out_time_panel.visible = false
			outbounds_time = 0.0
		#var c_image = sprite.texture.get_image()
		var loc : Color = Global.current_height_map.get_pixel(blimp_pos.x, blimp_pos.y)
		#var loc : Color = c_image.get_pixel(blimp_pos.x, blimp_pos.y)
		var ground_height = loc.r8 * Global.CONTOUR_MULT
		
		
		if blimp.get_height() <= ground_height:
			blimp.stop()
			update_time = false
			end_panel.setup_panel(1,time_elapsed)
			end_panel.visible = true
			
		ground_height_label.text = str(ground_height) 
	
	else:
		if inbounds:
			inbounds = false
			out_time_panel.visible = true
			
	
	position_label.text = (str(blimp_pos.x) + "," + str(blimp_pos.y))
	
	
	# update ui
	direction_sprite.look_at(destination.position)
	#var radians: float = deg_to_rad(-90)
	#direction = Vector2.RIGHT.rotated(radians)
	#wind_sprite.rotation_degrees = -90
	buoy_label.text = str(blimp.get_buoyancy())
	height_label.text = str(snappedf(blimp.height, 0.01))
	
	time_label.text = "Time: " + str(snappedf(time_elapsed,0.01))
	speed_label.text = str(blimp.get_speed())
	if blimp.get_b_rotation() == 1:
		rr_button.modulate = Global.ACTIVE_COLOR
		lr_button.modulate = Color.WHITE
	elif blimp.get_b_rotation() == -1:
		rr_button.modulate = Color.WHITE
		lr_button.modulate = Global.ACTIVE_COLOR
	else:	
		rr_button.modulate = Color.WHITE
		lr_button.modulate = Color.WHITE
		lr_button.modulate = Color.WHITE
		lr_button.modulate = Color.WHITE

func _on_stop_button_pressed() -> void:
	blimp.stop()


func _on_bup_button_pressed() -> void:
	blimp.increase_speed()

func _on_b_down_button_pressed() -> void:
	blimp.decrease_speed()
	
#func _on_bup_button_button_down() -> void:
##	blimp.start_increase_height()


#func _on_bup_button_button_up() -> void:
#	blimp.stop_increase_height()


#func _on_exit_button_pressed() -> void:
#	get_tree().change_scene_to_file("res://scenes/start_scene.tscn")


#func _on_restart_button_pressed() -> void:
#	get_tree().change_scene_to_file("res://scenes/map.tscn")


func _on_rr_button_pressed() -> void:
	blimp.right_rudder()
	rr_button.modulate = Global.ACTIVE_COLOR
	lr_button.modulate = Color.WHITE
	


func _on_rl_button_pressed() -> void:
	blimp.left_rudder()
	lr_button.modulate = Global.ACTIVE_COLOR
	rr_button.modulate = Color.WHITE


func _on_rs_button_pressed() -> void:
	blimp.stop_rudder()
	rr_button.modulate = Color.WHITE
	lr_button.modulate = Color.WHITE


func _on_buoy_up_button_pressed() -> void:
	blimp.increase_buoyancy()


func _on_buoy_donw_button_pressed() -> void:
	blimp.decrease_buoyancy()
	
func _reached_destination() -> void:
	update_time = false
	end_panel.setup_panel(0,time_elapsed)
	end_panel.visible = true
	
func rotation_to_direction(rotation_degrees: float) -> Vector2:
	# Convert rotation from degrees to radians (skip if already in radians)
	var rotation_radians = deg_to_rad(rotation_degrees)

	# Calculate direction vector
	var direction = Vector2(cos(rotation_radians), sin(rotation_radians))

	# Normalize the vector (optional, but ensures length = 1)
	direction = direction.normalized()

	return direction
