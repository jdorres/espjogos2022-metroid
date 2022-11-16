extends Camera2D


export var nodePlayer: NodePath
var player
var stage1Limit = Vector2(330, 1110)

func _ready():
	player = get_node(nodePlayer);
	
func _process(delta):
	if(player.position.x > stage1Limit.x && player.position.x < stage1Limit.y):
		position.x = player.position.x
