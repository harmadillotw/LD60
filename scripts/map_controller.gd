extends Node2D

@export var sprite : Sprite2D
@export var blimp :CharacterBody2D

@export var position_label : Label

@export var height_label : Label
@export var speed_label : Label

@export var time_label : Label

@export var crashed_label : Label

@export var end_panel : Panel


@export var color_height : Array[Color]

var time_elapsed : float
var update_time : bool
var sprite_pos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_pos = sprite.position
	sprite.texture = Global.current_display_map
	time_elapsed = 0.0
	update_time = true
	#sprite.texture = ImageTexture.create_from_image(Global.current_map)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#check blimp position
	if update_time:
		time_elapsed += delta
	var blimp_pos = blimp.global_position
	var c_image = sprite.texture.get_image()
	var loc : Color = c_image.get_pixel(blimp_pos.x, blimp_pos.y)

	print(str(loc.r8))
	if blimp.get_height() <= loc.r8:
		blimp.stop()
		update_time = false
		end_panel.visible = true
	#loc.r8 = 255
	#loc.g8 = 255
	#loc.b8 = 255
	#c_image.set_pixel(blimp_pos.x, blimp_pos.y, loc)
	sprite.texture = ImageTexture.create_from_image(c_image)
	position_label.text = (str(blimp_pos.x) + "," + str(blimp_pos.y))
	speed_label.text = "S:" + str(blimp.get_speed())
	
	# update ui
	height_label.text = "H:" + (str(snappedf(blimp.height, 0.01)))
	time_label.text = "T:" + str(snappedf(time_elapsed,0.01))


func _on_stop_button_pressed() -> void:
	blimp.stop()


func _on_bup_button_pressed() -> void:
	pass


func _on_bup_button_button_down() -> void:
	blimp.start_increase_height()


func _on_bup_button_button_up() -> void:
	blimp.stop_increase_height()


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_scene.tscn")


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map.tscn")
