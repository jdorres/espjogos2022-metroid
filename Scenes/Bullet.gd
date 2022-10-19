extends Sprite

var direction

func _physics_process(delta):
	position.x = position.x + 3000 * delta * direction
	
func setDirection(dir):
	if(dir == 0):
		direction = -1
	else:
		direction = 1
