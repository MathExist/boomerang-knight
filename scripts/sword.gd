extends CharacterBody2D

var speed = 150
var direction = Vector2.RIGHT   # the player sets this when throwing

func _ready():
	# go with dir & speed
	velocity = direction * speed

func _physics_process(delta):
	var hit = move_and_collide(velocity * delta)

	if hit:
		var other = hit.get_collider()
		if other.is_in_group("enemies"):
			other.queue_free()
			Game.score += 1
