extends KinematicBody2D

onready var player := $Sprite
onready var animation_tree = get_node("AnimationTree")
onready var animation_mode = animation_tree.get("parameters/playback")

export (PackedScene) var box : PackedScene
export (int) var speed = 250
export var gravity = 1500
export var jump_speed = 500

var velocity = Vector2()
var jumping = false
var player_dir = 1
var player_form = 'standing'
var bullet_dist = 0
var bullet_dist_left = Vector2(60, -20)
var bullet_dist_right = Vector2(-60, -20)
var bullet_dist_up_left = Vector2(20,-65)
var bullet_dist_up_right = Vector2(-20,-65)
var life_bar = 30

func _ready() -> void:
	animation_mode.start("Idle")

func _physics_process(delta):
	get_8way_input()
	get_action_buttons()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
func get_8way_input():
	if(is_on_floor()):
		jumping = false
		velocity.x = Input.get_action_strength("right")-Input.get_action_strength("left")
		
		if velocity.x != 0:	
			player_dir = velocity.x
			if player_dir > 0:
				player.scale.x = 1
			else:
				player.scale.x = -1
				player.scale.x = -1
		
		velocity = velocity.normalized() * speed
		
		if player_form == 'standing':
			animation_mode.travel("Running")
			if velocity.x == 0:
				animation_tree.set("parameters/Idle/blend_position", player_dir)
				animation_mode.travel("Idle")
				
		elif player_form == 'ball':
			animation_tree.set("parameters/Ball/blend_position", player_dir)
			
func get_action_buttons():
	if player_form == 'standing':
		if Input.is_action_pressed("jump") and jumping == false:
			jumping = true
			velocity.y = -jump_speed
			animation_tree.set("parameters/Jumping/blend_position", player_dir)
			animation_mode.travel("Jumping")
					
		if Input.is_action_just_pressed("shoot_up"):
			if(player_dir == -1):
				bullet_dist = bullet_dist_up_right
			else:
				bullet_dist = bullet_dist_up_left
			Global.bullet_direction = 2
			var b := box.instance()
			b.position = global_position + bullet_dist
			get_parent().add_child(b)
			
		if Input.is_action_just_pressed("shoot") and Input.is_action_just_pressed("up"):
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
			player_form = 'ball'
			animation_mode.travel("Ball")
	
	if player_form == 'ball':
		if Input.is_action_just_pressed("up"):
			$CollisionShape2D.scale.y = 1
			$CollisionShape2D.scale.x = 1
			player_form = 'standing'
			animation_mode.travel("Idle")
			
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

