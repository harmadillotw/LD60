extends Node2D

@export var maps : Dictionary[String,Texture2D] 
@export var color_height : Array[Color]
@export var map_configs : Array[MapConfig]

@export var level_select : OptionButton
var current_map : int
var tg 
var width = 1920
var height  = 1080
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.current_map = 2
	create_map_list()
	tg = get_node("TerrainGenerator")
	current_map = 0
	for x in 22:
		color_height.append(  Color.html(Global.color_height[x]))
	var map : Texture2D  = Global.map_configs[Global.current_map].map_texture
	#var map : Texture2D  = maps.get("map1")
	#Global.current_display_map = maps.get("map1")
	Global.current_height_map = map.get_image()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_generate_button_pressed() -> void:
	tg.generate_height_map()


func _on_start_button_pressed() -> void:
	Global.generated_level = false
	Global.current_map = level_select.selected
	create_display_map()
	get_tree().change_scene_to_file("res://scenes/map.tscn")
	
func create_display_map() -> void:
	if Global.generated_level:
		Global.current_height_map = Global.current_gen_map
	else:
		Global.current_height_map = Global.map_configs[Global.current_map].map_texture.get_image()
	var image := Image.new()
	print(str(image.get_width()) + "," + str(image.get_height()))
	image.create_empty(width,height, false,Image.FORMAT_RGB8)
	var buffer:= PackedByteArray()
	buffer.resize(width * height * 3)
	buffer = image.get_data()
	for y in width:
		for x in height:		
			var grayscale_value = 1
			buffer.append(grayscale_value) # Red
			buffer.append(grayscale_value) # Green
			buffer.append(grayscale_value) # Blue
	image.set_data(width,height,false,Image.FORMAT_RGB8, buffer)
	print(str(image.get_width()) + "," + str(image.get_height()))
	for y in image.get_width():
		for x in image.get_height():
			var height_value = Global.current_height_map.get_pixel(y,x).r8
			var color = height_to_color(height_value)
	#		var test = image.get_pixel(x,y)
	#		print(str(test.r8))
			image.set_pixel(y,x,color)
	Global.current_display_map = ImageTexture.create_from_image(image)
	
func height_to_color(height : float) -> Color:
	#for i in range (23,-1,-1):
	for i in 22:
		if height < i * Global.CONTOUR_GAP:
			return color_height[i] 
			
	return color_height[0] 
	
func create_map_list() -> void:
	var map_config = MapConfig.new()
	#map_config.map_texture =
	#map_config.start_loction = Vector2(0,0)
	#map_config.destination_location = Vector2(0,0)
	#map_config.wind_direction =
	#map_config.wind_speed =
	#map_config.start_height = 
	
	map_config.map_texture = load("res://images/map1.png")
	map_config.start_loction = Vector2(1172,981)
	map_config.destination_location = Vector2(296,143)
	map_config.wind_direction = -45
	map_config.wind_speed =5
	map_config.start_height = 100
	Global.map_configs.append(map_config)
	
	map_config = MapConfig.new()
	map_config.map_texture = load("res://images/map2.png")
	map_config.start_loction = Vector2(1605,730)
	map_config.destination_location = Vector2(873,597)
	map_config.wind_direction = -45
	map_config.wind_speed =10
	map_config.start_height = 100
	Global.map_configs.append(map_config)
	
	map_config = MapConfig.new()
	map_config.map_texture = load("res://images/map3.png")
	map_config.start_loction = Vector2(1295,592)
	map_config.destination_location = Vector2(138,152)
	map_config.wind_direction = 90
	map_config.wind_speed =25
	map_config.start_height = 100
	Global.map_configs.append(map_config)
	pass


func _on_gen_start_button_pressed() -> void:
	Global.generated_level = true
	Global.current_map = level_select.selected
	Global.gen_map_config = MapConfig.new()
	Global.gen_map_config.map_texture = ImageTexture.create_from_image(Global.current_gen_map)
	Global.gen_map_config.start_loction = Vector2(1172,981)
	Global.gen_map_config.destination_location = Vector2(296,143)
	Global.gen_map_config.wind_direction = -45
	Global.gen_map_config.wind_speed =5
	Global.gen_map_config.start_height = Global.current_gen_map.get_pixel(1172,981).r8 + 100
	Global.current_display_map = Global.gen_map_config.map_texture
	create_display_map()
	get_tree().change_scene_to_file("res://scenes/map.tscn")
