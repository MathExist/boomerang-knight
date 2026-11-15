extends CharacterBody2D

const SPEED = 200.0
const JUMP_FORCE = -400.0

@onready var sprite = $AnimatedSprite2D
@onready var sword_hit: AudioStreamPlayer2D = $"../SwordHit"
@onready var walk: AudioStreamPlayer2D = $"../Walk"

var hits = 0
var sword_scene = preload("res://scenes/sword.tscn")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var launch_dir = Vector2.ZERO

var is_jump = false
var is_attack = false

func _ready():
	sprite.animation_finished.connect(_on_animation_finished)

# jump & attack (without won't work)
func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_W and not is_attack:
			velocity.y = JUMP_FORCE
			is_jump = true
			sprite.play("jump")

		if event.keycode == KEY_E and not is_attack:
			is_attack = true
			sprite.play("attack")
			sword_hit.play()
			throw_sword()

# send sword to cursor
func throw_sword():
	var sword = sword_scene.instantiate()
	var dir = (get_global_mouse_position() - global_position).normalized()
	sword.direction = dir                         # set direction BEFORE add_child
	sword.global_position = global_position + dir * 40   # start a bit in front of the knight
	get_tree().current_scene.add_child(sword)

	# face the cursor while throwing
	sprite.flip_h = dir.x < 0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	# find dir
	var direction = 0
	if Input.is_physical_key_pressed(KEY_A):
		direction = -1
	if Input.is_physical_key_pressed(KEY_D):
		direction = 1

	# move it
	velocity.x = direction * SPEED

	# flip sprite
	if direction == -1:
		sprite.flip_h = true
	elif direction == 1:
		sprite.flip_h = false

	move_and_slide()

	# idle or walking if no "action"?
	if not is_jump and not is_attack:
		if direction != 0:
			sprite.play("walk")
			walk.play()
		else:
			sprite.play("idle")

# animation done?
func _on_animation_finished():
	if sprite.animation == "jump":
		is_jump = false
	if sprite.animation == "attack":
		is_attack = false

func get_hit():
	Game.health -= 1
	if Game.health <= 0:
		Game.reset()
		get_tree().reload_current_scene()
