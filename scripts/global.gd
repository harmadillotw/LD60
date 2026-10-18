extends Node

const CONTOUR_GAP = 10
const CONTOUR_MULT = 5
const ACTIVE_COLOR = Color.GOLDENROD
var current_height_map : Image
var current_display_map : Texture2D
var current_gen_map : Image

var map_configs : Array[MapConfig]
var gen_map_config : MapConfig
var current_map : int
var generated_level : bool


var color_height = ["#96bee1",
"#1aa14a",
"42af3b",
"6dbe39",
"afd755",
"efee6f",
"f4e669",
"f4db5f",
"f4d156",
"f4c64c",
"f3bb45",
"e8a946",
"df9a47",
"d58848",
"cc7949",
"bf7458",
"aa8083",
"968caa",
"b3acc1",
"d0ccd9",
"efedf2",
"ffffff"]
