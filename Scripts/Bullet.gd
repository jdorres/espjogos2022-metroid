extends Area2D

var bullet_dir
var pos_x
var pos_y
func _ready() -> void:
	bullet_dir = Global.bullet_direction
	pos_x = position.x
	pos_y = position.y
	
func _physics_process(delta):
	if bullet_dir == 1 or bullet_dir == -1:
		position.x = position.x + 700 * delta * bullet_dir
		position.y = pos_y
	else:
		position.y = position.y + 700 * delta * -1
		position.x = pos_x
		
	yield(get_tree().create_timer(0.25), "timeout")
	queue_free()
	
func _on_Bullet_body_entered(body):
	if body.is_in_group("enemy"):
		body.hit_points()
		queue_free()
