extends Node2D

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


@export var color_height : Array[Color]

var time_elapsed : float
var update_time : bool
var sprite_pos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.reached_destination.connect(_reached_destination)
	sprite_pos = sprite.position
	sprite.texture = Global.current_display_map
	time_elapsed = 0.0
	update_time = true
	#sprite.texture = ImageTexture.create_from_image(Global.current_map)
	wind_sprite.rotation_degrees = -45
	blimp.set_wind(Vector2.from_angle(wind_sprite.rotation),5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#check blimp position
	if update_time:
		time_elapsed += delta
	var blimp_pos = blimp.global_position
	#var c_image = sprite.texture.get_image()
	var loc : Color = Global.current_height_map.get_pixel(blimp_pos.x, blimp_pos.y)
	#var loc : Color = c_image.get_pixel(blimp_pos.x, blimp_pos.y)
	var ground_height = loc.r8 * Global.CONTOUR_MULT
	
	
	if blimp.get_height() <= ground_height:
		blimp.stop()
		update_time = false
		end_panel.setup_panel(false,time_elapsed)
		end_panel.visible = true
	#loc.r8 = 255
	#loc.g8 = 255
	#loc.b8 = 255
	#c_image.set_pixel(blimp_pos.x, blimp_pos.y, loc)
	#sprite.texture = ImageTexture.create_from_image(c_image)
	position_label.text = (str(blimp_pos.x) + "," + str(blimp_pos.y))
	
	
	# update ui
	direction_sprite.look_at(destination.position)
	#var radians: float = deg_to_rad(-90)
	#direction = Vector2.RIGHT.rotated(radians)
	#wind_sprite.rotation_degrees = -90
	buoy_label.text = str(blimp.get_buoyancy())
	height_label.text = str(snappedf(blimp.height, 0.01))
	ground_height_label.text = str(ground_height) 
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
	end_panel.setup_panel(true,time_elapsed)
	end_panel.visible = true
