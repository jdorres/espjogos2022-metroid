extends KinematicBody2D

var hit = 0
export var movement_direction = 'right'
onready var right_collision = $Right_Collision
onready var left_collision = $Left_Collision

export (int) var speed = 200
export (float) var rotation_speed = 1.5
var velocity = Vector2()

func _physics_process(delta):
	if movement_direction == 'right':
		velocity = Vector2(speed, 0).rotated(rotation)
	else:
		velocity = Vector2(-speed, 0).rotated(rotation) 
	 
	
	if right_collision.is_colliding() and right_collision.get_collider().name == 'TileMap2' and movement_direction == 'left':
		#print(right_collision.get_collider().name)
		rotation_degrees += 90
		
	if left_collision.is_colliding() and left_collision.get_collider().name == 'TileMap2'  and movement_direction == 'right' :
		#print(left_collision.get_collider().name)
		rotation_degrees -= 90
	 
 
	velocity = move_and_slide(velocity)

func _on_Floor_Collision_body_exited(body):
	
	if(body.is_in_group("player")):
		return
	if movement_direction == 'left':
		rotation_degrees += -90
	if movement_direction == 'right':
		rotation_degrees += +90 

func hit_points():
	hit += 1 
	if hit == 2:
		queue_free()

func _on_Body_Collision_body_entered(body):
	if body.is_in_group("player"):  
		if Global.invincibility == false: 
			body.hit_points(global_position, 8)
			


