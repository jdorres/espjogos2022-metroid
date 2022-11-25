extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print('hey')
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:

	if Global.morphball == true:
		queue_free()
		print("free")
		
		
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		Global.morphball = true;
		print('Player has entered')

