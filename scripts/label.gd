extends Label

func _process(delta):
	text = "Kills: " + str(Game.score) + "   Health: " + str(Game.health)
