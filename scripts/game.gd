extends Node

var score = 0
var max_health = 10
var health = 10

var layer
var health_bar
var health_label
var score_label

func _ready():
	layer = CanvasLayer.new()
	layer.layer = 100
	add_child(layer)

	# HEALTH BAR
	health_bar = ProgressBar.new()
	health_bar.position = Vector2(20, 20)
	health_bar.custom_minimum_size = Vector2(220, 28)
	health_bar.max_value = max_health
	health_bar.value = health
	health_bar.show_percentage = false
	var fill = StyleBoxFlat.new()
	fill.bg_color = Color.RED
	health_bar.add_theme_stylebox_override("fill", fill)
	layer.add_child(health_bar)

	# HEALTH TEXT (sits on top of the bar, centered)
	health_label = Label.new()
	health_label.set_anchors_preset(Control.PRESET_FULL_RECT)   # fill the whole bar
	health_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	health_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	health_label.add_theme_font_size_override("font_size", 16)
	health_label.add_theme_color_override("font_color", Color.WHITE)
	health_label.add_theme_color_override("font_outline_color", Color.BLACK)
	health_label.add_theme_constant_override("outline_size", 6)
	health_bar.add_child(health_label)

	# SCORE TEXT
	score_label = Label.new()
	score_label.position = Vector2(20, 58)
	score_label.add_theme_font_size_override("font_size", 28)
	score_label.add_theme_color_override("font_color", Color.WHITE)
	score_label.add_theme_color_override("font_outline_color", Color.BLACK)
	score_label.add_theme_constant_override("outline_size", 8)
	layer.add_child(score_label)

	# OPTIONAL FONT (change the path, or delete these 4 lines)
	var font = load("res://fonts/myfont.ttf")
	if font:
		health_label.add_theme_font_override("font", font)
		score_label.add_theme_font_override("font", font)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):   # Space or Enter
		health -= 1
	# only show the HUD when a player exists (so not on the main menu)
	layer.visible = get_tree().get_first_node_in_group("player") != null

	health_bar.value = health
	health_label.text = "Health: " + str(health) + " / " + str(max_health)
	score_label.text = "Kills: " + str(score)

func reset():
	score = 0
	health = max_health
