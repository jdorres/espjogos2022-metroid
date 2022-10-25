extends KinematicBody2D

var velocity = Vector2()
var speed = 40
var movement_direction = 'left'

export var direction = Vector2.LEFT
onready var right_collision = $Right_Collision
onready var left_collision = $Left_Collision
onready var right_floor = $Right_Floor_Collision
onready var left_floor = $Left_Floor_Collision

func _process(delta):
	velocity = speed * direction
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if not right_floor.is_colliding() and movement_direction == 'right':
		direction = Vector2.DOWN
		rotation_degrees = 90

	if not left_floor.is_colliding() and movement_direction == 'left':
		direction = Vector2.DOWN
		rotation_degrees = 270
		
	if left_collision.is_colliding() and movement_direction == 'right':
		print('left')
		direction = Vector2.RIGHT
		rotation_degrees = 0
		
	if right_collision.is_colliding() and movement_direction == 'left':
		direction = Vector2.LEFT
		rotation_degrees = 0
		print('right')
		

func _on_FloorChecker_body_exited(body):
	#direction = Vector2.DOWN
	#rotation_degrees = -90
	pass
	
func _on_WallChecker_body_entered(body):
	pass
	#direction = Vector2.UP
