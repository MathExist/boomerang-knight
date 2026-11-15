extends Node

var score = 0     # kills
var health = 100
var label

func _ready():
	print("Game script is running")

	# make a CanvasLayer (stays fixed on screen) and a label inside it
	var layer = CanvasLayer.new()
	layer.layer = 100
	add_child(layer)

	label = Label.new()
	label.position = Vector2(20, 20)
	label.add_theme_font_size_override("font_size", 28)
	label.add_theme_color_override("font_color", Color.WHITE)
	label.add_theme_color_override("font_outline_color", Color.BLACK)
	label.add_theme_constant_override("outline_size", 8)
	layer.add_child(label)

func _process(delta):
	label.text = "Kills: " + str(score) + "   Health: " + str(health)

func reset():
	score = 0
	health = 10
