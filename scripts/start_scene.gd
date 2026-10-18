extends Node2D

@export var maps : Dictionary[String,Texture2D] 
@export var color_height : Array[Color]
var current_map : int
var tg 
var width = 1920
var height  = 1080
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	tg = get_node("TerrainGenerator")
	current_map = 0
	for x in 22:
		color_height.append(  Color.html(Global.color_height[x]))
	var map : Texture2D  = maps.get("map1")
	Global.current_display_map = maps.get("map1")
	Global.current_height_map = map.get_image()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_generate_button_pressed() -> void:
	tg.generate_height_map()


func _on_start_button_pressed() -> void:
	#var map : Texture2D  = maps.get("test")
	#Global.current_display_map = maps.get("test")
	#Global.current_height_map = map.get_image()
	create_display_map()
	get_tree().change_scene_to_file("res://scenes/map.tscn")
	
func create_display_map() -> void:
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
