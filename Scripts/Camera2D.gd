extends Camera2D


export var nodePlayer: NodePath
var player
var stage1Limit = Vector2(330, 1110)
var cameraLimit= Vector2() 
var x_camera_limits=100;
func _ready():
	player = get_node(nodePlayer);

func _process(delta): 
	if(player.global_position.x >= (global_position.x+x_camera_limits) or player.global_position.x <=  (global_position.x-x_camera_limits)):
		if(global_position.x < player.global_position.x ):
			global_position.x+=player.speed*delta;
		elif(global_position.x > player.global_position.x ):
			global_position.x-=player.speed*delta;
		else:
			global_position.x+=0

