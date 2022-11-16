extends KinematicBody2D

var hit = 0
export var movement_direction = 'right'
onready var right_collision = $Right_Collision
onready var left_collision = $Left_Collision

export (int) var speed = 100
export (float) var rotation_speed = 1.5
var velocity = Vector2()

func _physics_process(delta):
	if movement_direction == 'right':
		velocity = Vector2(speed, 0).rotated(rotation)
	else:
		velocity = Vector2(-speed, 0).rotated(rotation)
	velocity = move_and_slide(velocity)
	
	if right_collision.is_colliding() and movement_direction == 'left':
		rotation_degrees += 90
		
	if left_collision.is_colliding() and movement_direction == 'right':
		rotation_degrees -= 90

func _on_Floor_Collision_body_exited(body):
	if movement_direction == 'left':
		rotation_degrees += -90
	if movement_direction == 'right':
		rotation_degrees += +90
	
func hit_points():
	hit += 1
	print('enemy hit')
	if hit == 2:
		queue_free()

func _on_Body_Collision_body_entered(body):
	if body.is_in_group("player"):
		if Global.invincibility == false:
			print('Player hit')
			body.hit_points(global_position, 8)
			


