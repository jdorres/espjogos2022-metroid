extends Area2D

var pos_x
var pos_y

onready var timer := $Timer

func _ready() -> void:
		timer.connect("timeout", self, "queue_free")
		timer.set_wait_time(9)
		timer.start()
	
func _on_Life_body_entered(body):
	if body.is_in_group("player"):
		Global.player_life_points += 5
		queue_free()
