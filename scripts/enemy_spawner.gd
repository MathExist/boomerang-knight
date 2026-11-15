extends Node

var enemy_scene = preload("res://scenes/enemy.tscn")   # your path
var max_enemies = 30

func _ready():
	# spawner ready
	$Timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	if get_tree().get_nodes_in_group("enemies").size() >= max_enemies:
		return

	var points = get_tree().get_nodes_in_group("spawn_points")
	if points.is_empty():
		return

	var point = points.pick_random()
	var enemy = enemy_scene.instantiate()
	enemy.global_position = point.global_position
	get_tree().current_scene.add_child(enemy)
