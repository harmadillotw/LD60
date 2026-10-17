extends Node2D

var rng = RandomNumberGenerator.new()

var noise: FastNoiseLite
@export var width : int = 1920
@export var height : int = 1080
@export var noise_scale : float = 0.1
@export var image : Image
@export var sprite : Sprite2D

var height_map : PackedFloat64Array

func _ready():
	_init_noise()
	#_generate_height_map()
	
func _init_noise():
	noise = FastNoiseLite.new()
	noise.seed = rng.randi()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = 0.003
	
func generate_height_map():
	print("start generation")
	for y in width:
		for x in height:
			var value : float =	(noise.get_noise_2d(x,y) +1)* 127.5
			var out_value : float =0
			if value > 200:
				out_value = 200
			elif value > 150:
				out_value = 150
			elif value > 100:
				out_value = 100
			elif value > 50:
				out_value = 50
			else :
				out_value = 0
			
			height_map.append(out_value)
	print("save_file")
	_save_to_file()
			
func _save_to_file():
	var image := Image.new()
	image.create(width,height, false,Image.FORMAT_RGB8)
	print("gen" + str(image.get_width()) + "," + str(image.get_height()))
	var buffer:= PackedByteArray()
	buffer.resize(width * height * 3)
	buffer = image.get_data()
	
	for y in width:
		for x in height:
			#var grayscale_value = int((height_map[y * height + x] + 1)* 127.5)
			var grayscale_value = int((height_map[y * height + x]))
			
			buffer.append(grayscale_value) # Red
			buffer.append(grayscale_value) # Green
			buffer.append(grayscale_value) # Blue
	
	print("gen" + str(image.get_width()) + "," + str(image.get_height()))
	image.set_data(width,height,false,Image.FORMAT_RGB8, buffer)
	print("gen" + str(image.get_width()) + "," + str(image.get_height()))
	Global.current_height_map = image
	#image.save_png("res://height_map.png")
	sprite.texture = ImageTexture.create_from_image(image)
	
	
	
