extends KinematicBody2D


var velocity = Vector2()
export (int) var speed = 250
export var gravity = 2500
export var jump_speed = 1000
onready var player := $Sprite
var player_dir = 1 # 0 - left, 1 - right

export (PackedScene) var box : PackedScene

func _ready() -> void:
	player.stop()

func _physics_process(delta):
	get_8way_input()
	get_action_buttons()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func get_8way_input():
	
	if(is_on_floor()):
		velocity.x = Input.get_action_strength("right")-Input.get_action_strength("left")
		var velocity_2 = velocity.normalized() * speed
		velocity.x =velocity_2.x
		if velocity.x < 0:
			player_dir = 0
			player.play("walk-left")
		elif velocity.x > 0:
			player_dir = 1
			player.play("walk-right")
		elif velocity.y > 0:
			print("down")
		elif velocity.y < 0:
			print("up")
		else:
			player.frame = 0
			if(is_on_floor()):
				if(player_dir == 0):
					player.play("idle-left")
				else:
					player.play("idle-right")
			player.stop()
		
func get_action_buttons():
	var jump_ajust: float = jump_speed
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_ajust
		if(is_on_floor()):
			if(player_dir == 0):
				player.play("jump-left")
			else:
				player.play("jump-right")
	if Input.is_action_just_pressed("shoot"):
		var b := box.instance()
		b.setDirection(player_dir)
		b.position = global_position
		owner.add_child(b)
