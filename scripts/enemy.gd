extends CharacterBody2D

const SPEED = 100.0
var player = null
var is_attacking = false

@onready var sprite = $AnimatedSprite2D

func _ready():
	add_to_group("enemies")
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	# attacking/no player
	if is_attacking or player == null:
		velocity = Vector2.ZERO
		if not is_attacking:
			sprite.play("idle")
		return

	# fly to player
	var to_player = player.global_position - global_position
	velocity = to_player.normalized() * SPEED
	sprite.flip_h = to_player.x < 0
	sprite.play("walk")
	move_and_slide()

	# attack
	if to_player.length() < 40:
		attack()

func attack():
	is_attacking = true
	sprite.play("attack")
	# player get hit
	player.get_hit()
	await sprite.animation_finished
	queue_free()
