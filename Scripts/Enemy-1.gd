extends KinematicBody2D

var hit = 0
var movement_direction = 'left'
onready var right_collision = $Right_Collision

export (int) var speed = 100
export (float) var rotation_speed = 1.5
var velocity = Vector2()

func _on_Left_Floor_Collision_body_exited(body):
	rotation_degrees += -90

func _physics_process(delta):
	velocity = Vector2(-speed, 0).rotated(rotation)
	velocity = move_and_slide(velocity)
	if right_collision.is_colliding() and movement_direction == 'left':
		rotation_degrees += 90

func hit_points():
	hit += 1
	print('hit')
	if hit == 2:
		queue_free()
