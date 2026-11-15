extends AnimatableBody2D

var spin_speed = 0.5   # bigger = faster, negative = other direction

func _physics_process(delta):
	rotation += spin_speed * delta
