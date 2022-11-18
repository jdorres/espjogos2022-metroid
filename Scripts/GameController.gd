extends Node2D

onready var bullet_pos_left = get_node('BulletPositions/ShootingLeft')
onready var bullet_pos_right = get_node('BulletPositions/ShootingRight')
onready var bullet_pos_up_left = get_node('BulletPositions/ShootingUpLeft')
onready var bullet_pos_up_right = get_node('BulletPositions/ShootingUpRight')
onready var bullet_pos_up = get_node('BulletPositions/ShootingUp')

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
