extends RigidBody2D

var bullet_dir = Global.bullet_direction

func _physics_process(delta):
	
	if bullet_dir == 1 or bullet_dir == -1:
		position.x = position.x + 1500 * delta * bullet_dir
	else:
		position.y = position.y + 1500 * delta * -1
	
func _on_Bullet_body_entered(body):
	if body.is_in_group("enemy"):
		body.hit_points()
		queue_free()
	pass # Replace with function body.
