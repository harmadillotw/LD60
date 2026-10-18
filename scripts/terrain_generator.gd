extends Node2D

var rng = RandomNumberGenerator.new()


@export var noise: FastNoiseLite
@export var width : int = 1920
@export var height : int = 1080
@export var noise_scale : float = 0.1
@export var image : Image
@export var sprite : Sprite2D
@export var textrec : TextureRect

var height_map : PackedFloat64Array

func _ready():
	_init_noise()
	#_generate_height_map()
	
func _init_noise():
	pass
	#noise = FastNoiseLite.new()
	#noise.seed = rng.randi()
	#noise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	#
	#noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	#noise.fractal_octaves = 2
	#noise.frequency = 0.01
	#noise.cellular_return_type = FastNoiseLite.RETURN_DISTANCE2_MUL
	#noise.domain_warp_enabled = true
	
func generate_height_map():
	height_map.clear()
	randomize()
	noise.seed = randi()
	print(str(noise.seed))
	print("start generation")
	var max =0
	var min =0
	var testmap = noise.get_image(1920,1080,false,false,false)
	#testmap.resize(1920,1080)
	testmap.save_png("res://kel_test.png")

	var testout = Image.create(1920,1080, false,Image.FORMAT_RGB8)
	for x in 1920:
		for y in 1080:
			var value = (testmap.get_pixel(x,y).r8 )
			

			#var out_value = value
			if value < min:
				min = value
			if value > max:
				max = value
			var pic_color : int = (value -10) / 10
			if pic_color < Global.color_height.size() -1:
				testout.set_pixel(x,y,Global.color_height[pic_color])			
			else:
				testout.set_pixel(x,y,Global.color_height[Global.color_height.size() -1])
	Global.current_gen_map = testout
	#sprite.texture = ImageTexture.create_from_image(image)
	sprite.texture = ImageTexture.create_from_image(testout)
	textrec.texture= ImageTexture.create_from_image(testout)
			#height_map.append(out_value)
			#var value : float =	snappedi(abs(roundi(noise.get_noise_2d(x ,y) * 200) ),10)
			#var value : float = abs(noise.get_noise_2d(x * 0.001 ,y *0.001)) * 1000
			
			
			#var out_value = 0
			#if value < 150:
				#out_value = 50
			#else:
				#out_value = 100
			
			#var out_value : float =0
			#if value < 0.05:
			#	out_value = 0
			#elif value < -0.05:
				#out_value = 50
			#elif value < 0.0:
				#out_value = 100
			#elif value < 0.5:
				#out_value = 150
			#else:
			#	out_value =200
			
			#if value < -1.0:
				#out_value = 0
			#elif value < -0.9:
				#out_value = 10
			#elif value < -0.8:
				#out_value = 20
			#elif value < -0.7:
				#out_value = 30
			#elif value < -0.6:
				#out_value = 40
			#elif value < -0.5:
				#out_value = 50
			#elif value < -0.4:
				#out_value = 60
			#elif value < -0.3:
				#out_value = 70
			#elif value < -0.2:
				#out_value = 80
			#elif value < -0.1:
				#out_value = 90
			#elif value < 0.0:
				#out_value = 100
			#elif value < 0.1:
				#out_value = 110
			#elif value < 0.2:
				#out_value = 120
			#elif value < 0.3:
				#out_value = 130
			#elif value < 0.4:
				#out_value = 140
			#elif value < 0.5:
				#out_value = 150
			#elif value < 0.6:
				#out_value = 160
			#elif value < 0.7:
				#out_value = 170
			#elif value < 0.8:
				#out_value = 180
			#elif value < 0.9:
				#out_value = 190
			#else :
				#out_value = 200
			
			#height_map.append(out_value)
	print("MIN: "  + str(min))
	print("MAX: "  + str(max))
	print("save_file")
	#_save_to_file()
			
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
	#Global.current_height_map = image
	#image.save_png("res://height_map.png")
	sprite.texture = ImageTexture.create_from_image(image)
	
	
	
