extends KinematicBody2D

var velocity = Vector2()
var speed = 40
export var direction = Vector2.LEFT

func _process(delta):
	velocity = speed * direction
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_FloorChecker_body_exited(body):
	direction = Vector2.DOWN
	rotation_degrees = -90

func _on_WallChecker_body_entered(body):
	print('collision wall')
	#direction = Vector2.UP
	
