extends KinematicBody2D

onready var player := $Sprite

export (PackedScene) var box : PackedScene
export (int) var speed = 250
export var gravity = 1500
export var jump_speed = 500

var velocity = Vector2()
var player_dir = 1
var player_form = 'standing'
var bullet_dist = 0
var bullet_dist_left = Vector2(60, -20)
var bullet_dist_right = Vector2(-60, -20)
var bullet_dist_up_left = Vector2(20,-65)
var bullet_dist_up_right = Vector2(-20,-65)
var life_bar = 30

func _ready() -> void:
	player.stop()

func _physics_process(delta):
	get_8way_input()
	get_action_buttons()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
func get_8way_input():
	
	if player_form == 'standing':
		if(is_on_floor()):
			velocity.x = Input.get_action_strength("right")-Input.get_action_strength("left")
			var velocity_2 = velocity.normalized() * speed
			velocity.x =velocity_2.x
			if velocity.x < 0:
				player_dir = -1
				player.flip_h = true
				player.play("walk")
			elif velocity.x > 0:
				player_dir = 1
				player.flip_h = false
				player.play("walk")
			else:
				player.frame = 0
				if(is_on_floor()):
					if(player_dir == -1):
						player.flip_h = true
						player.play("idle")
					else:
						player.flip_h = false
						player.play("idle")
				player.stop()
				
	if player_form == 'ball':
		if(is_on_floor()):
			velocity.x = Input.get_action_strength("right")-Input.get_action_strength("left")
			var velocity_2 = velocity.normalized() * speed
			velocity.x =velocity_2.x
			if velocity.x < 0:
				player_dir = -1
				player.flip_h = true
				player.play("ball_movement")
			elif velocity.x > 0:
				player_dir = 1
				player.flip_h = false
				player.play("ball_movement")
			elif velocity.y > 0:
				print("down")
			elif velocity.y < 0:
				print("up")
			else:
				player.frame = 0
				if(is_on_floor()):
					if(player_dir == -1):
						player.flip_h = true
						player.play("ball_movement")
					else:
						player.flip_h = false
						player.play("ball_movement")
				player.stop()
			
func get_action_buttons():
	if player_form == 'standing':
		var jump_ajust: float = jump_speed
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y = -jump_ajust
			if(is_on_floor()):
				if(player_dir == -1):
					player.flip_h = true
					player.play("jump")
				else:
					player.flip_h = false
					player.play("jump")
					
		if Input.is_action_just_pressed("shoot_up"):
			if(player_dir == -1):
				bullet_dist = bullet_dist_up_right
			else:
				bullet_dist = bullet_dist_up_left
			Global.bullet_direction = 2
			var b := box.instance()
			b.position = global_position + bullet_dist
			get_parent().add_child(b)
					
		if Input.is_action_just_pressed("shoot"):
			if(player_dir == 1):
				bullet_dist = bullet_dist_left
			else:
				bullet_dist = bullet_dist_right
			Global.bullet_direction = player_dir
			var b := box.instance()
			b.position = global_position + bullet_dist
			get_parent().add_child(b)
			
		if Input.is_action_just_pressed("down"):
			$CollisionShape2D.scale.y = 0.4
			$CollisionShape2D.scale.x = 0.8
			player.play("ball_movement")
			player_form = 'ball'
	
	if player_form == 'ball':
		if Input.is_action_just_pressed("up"):
			$CollisionShape2D.scale.y = 1
			$CollisionShape2D.scale.x = 1
			player_form = 'standing'
			
			
func hit_points(enemy_pos,damage):
	life_bar -= damage
	print(life_bar)
	if life_bar <= 0:
		print('game_over')
		$Sprite.hide()
		yield(get_tree().create_timer(1), "timeout")
		get_tree().reload_current_scene()

	else:
		Global.invincibility = true
		yield(get_tree().create_timer(1), "timeout")
		Global.invincibility = false

	

