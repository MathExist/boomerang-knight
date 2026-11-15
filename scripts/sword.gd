extends CharacterBody2D

var speed = 150
var direction = Vector2.RIGHT
@onready var timer: Timer = $Timer
@onready var enemy: CharacterBody2D = $"."

func _ready():
	velocity = direction * speed
	timer.start()

func _on_timer_timeout() -> void:
	queue_free()

func _physics_process(delta):
	var hit = move_and_collide(velocity * delta)

	if hit:
		var other = hit.get_collider()
		if other.is_in_group("enemies"):
			# enemy.play("death")
			other.queue_free()
			Game.score += 1

		velocity = velocity.bounce(hit.get_normal())
