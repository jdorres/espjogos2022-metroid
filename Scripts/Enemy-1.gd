extends KinematicBody2D

var velocity = Vector2()
var speed = 100
var movement_direction = 'left'

export var direction = Vector2.LEFT
onready var right_collision = $Right_Collision
onready var left_floor = $Left_Floor_Collision

func _process(delta):
	velocity = speed * direction
	velocity = move_and_slide(velocity, Vector2.UP)

	if right_collision.is_colliding() and movement_direction == 'left':
		changeDirection('right')
		rotation_degrees += 90

func _on_Left_Floor_Collision_body_exited(body):
	changeDirection('left')
	rotation_degrees += -90
	
func changeDirection(dir):
	if dir == 'left':
		if direction == Vector2.LEFT :
			direction = Vector2.DOWN
		elif direction == Vector2.DOWN :
			direction = Vector2.RIGHT
		elif direction == Vector2.RIGHT :
			direction = Vector2.UP
		elif direction == Vector2.UP :
			direction = Vector2.LEFT
	elif dir == 'right':
		if direction == Vector2.LEFT :
			direction = Vector2.UP
		elif direction == Vector2.UP :
			direction = Vector2.RIGHT
		elif direction == Vector2.RIGHT :
			direction = Vector2.DOWN
		elif direction == Vector2.DOWN :
			direction = Vector2.LEFT
