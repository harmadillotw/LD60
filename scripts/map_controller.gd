extends Node2D

@export var sprite : Sprite2D
@export var blimp :CharacterBody2D

@export var position_label : Label

@export var height_label : Label
@export var speed_label : Label

@export var color_height : Array[Color]

var sprite_pos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_pos = sprite.position
	sprite.texture = Global.current_display_map
	#sprite.texture = ImageTexture.create_from_image(Global.current_map)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#check blimp position
	var blimp_pos = blimp.global_position
	var c_image = sprite.texture.get_image()
	var loc : Color = c_image.get_pixel(blimp_pos.x, blimp_pos.y)

	#if (loc.r8 > 0):
	#	blimp.stop()
	loc.r8 = 255
	loc.g8 = 255
	loc.b8 = 255
	c_image.set_pixel(blimp_pos.x, blimp_pos.y, loc)
	sprite.texture = ImageTexture.create_from_image(c_image)
	position_label.text = (str(blimp_pos.x) + "," + str(blimp_pos.y))
	speed_label.text = str(blimp.get_speed())
	
	# update ui
	height_label.text = (str(blimp.height))


func _on_stop_button_pressed() -> void:
	blimp.stop()


func _on_bup_button_pressed() -> void:
	pass


func _on_bup_button_button_down() -> void:
	blimp.start_increase_height()


func _on_bup_button_button_up() -> void:
	blimp.stop_increase_height()
