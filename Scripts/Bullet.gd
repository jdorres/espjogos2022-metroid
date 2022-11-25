extends Area2D

var bullet_dir
var pos_x
var pos_y

onready var timer := $Timer

func _ready() -> void:
	timer.connect("timeout", self, "queue_free")
	timer.set_wait_time(0.25)
	timer.start()
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
	
func _on_Bullet_body_entered(body):
	if body.is_in_group("enemy"):
		body.hit_points()
		queue_free()
