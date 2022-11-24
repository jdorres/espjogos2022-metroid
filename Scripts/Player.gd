class_name Player
extends KinematicBody2D

onready var sprite := $Sprite
onready var collision := $CollisionShape2D
onready var state_machine := $StateMachine
onready var animation_tree = get_node("AnimationTree")
onready var animation_mode = get_node("AnimationPlayer")
onready var bullet_pos_left = get_node('BulletPositions/ShootingLeft')
onready var bullet_pos_right = get_node('BulletPositions/ShootingRight')
onready var bullet_pos_up_left = get_node('BulletPositions/ShootingUpLeft')
onready var bullet_pos_up_right = get_node('BulletPositions/ShootingUpRight')
onready var bullet_pos_up = get_node('BulletPositions/ShootingUp')

export (PackedScene) var box : PackedScene
export (int) var speed = 250
export var gravity = 3000
export var jump_speed = 1500

var velocity = Vector2()
var jumping = false
var player_dir = 1
var player_form = 'standing'
var bullet_dist = 0
var life_bar = 30

var shoot_sequencial=false
var first_shoot=true
var activate_pisca=true

var damage_taken = false
func _ready() -> void:
	animation_mode.play("Idle")

func _physics_process(delta): 
	get_action_buttons()   
	pass
	
 
	
func bala():
		var bullet := box.instance()
		if state_machine.state.get_name() == 'Idle' || state_machine.state.get_name() == 'Run':
			get_node("RestShoot").start()
			if sprite.flip_h == true:
				Global.bullet_direction = -1
				bullet_pos_left.add_child(bullet)
			elif sprite.flip_h == false:
				Global.bullet_direction = 1
				bullet_pos_right.add_child(bullet)
		if state_machine.state.get_name() == 'IdlePointingUp' || state_machine.state.get_name() == 'RunPointingUp' || state_machine.state.get_name() == 'JumpPointingUp':
			Global.bullet_direction = 0
			bullet_pos_up.add_child(bullet)	
func get_action_buttons():
	#	if player_form == 'standing':
			#		if Input.is_action_just_pressed("shoot_up"):
			#			if(player_dir == -1):
			#				bullet_dist = bullet_dist_up_right
			#			else:
			#				bullet_dist = bullet_dist_up_left
			#			Global.bullet_direction = 2
			#			var b := box.instance()
			#			b.position = global_position + bullet_dist
			#			get_parent().add_child(b)
			#
			#	if Input.is_action_just_pressed("shoot") and Input.is_action_just_pressed("up"):
			#		if(player_dir == -1):
			#			bullet_dist = bullet_dist_up_right
			#		else:
			#			bullet_dist = bullet_dist_up_left
			#		Global.bullet_direction = 2
			#		var b := box.instance()
			#		b.position = global_position + bullet_dist
			#		get_parent().add_child(b)
			#
	if Input.is_action_pressed("shoot"):
		if(first_shoot):
			bala()
			first_shoot=false
			$InBetweenShoot.start()
		 
#		if Input.is_action_just_pressed("shoot"):
#			if(player_dir == 1):
#				bullet_dist = bullet_dist_left
#			else:
#				bullet_dist = bullet_dist_right
#			Global.bullet_direction = player_dir
#			var b := box.instance()
#			b.position = global_position + bullet_dist
#			get_parent().add_child(b)
			
#	if Input.is_action_just_pressed("down"):
#			CollisionShape2D.scale.y = 0.4
#			CollisionShape2D.scale.x = 0.8
#			player_form = 'ball'
#			animation_mode.travel("Ball")
#
#	if player_form == 'ball':
#		if Input.is_action_just_pressed("up"):
#			$CollisionShape2D.scale.y = 1
#			$CollisionShape2D.scale.x = 1
#			player_form = 'standing'
#			animation_mode.travel("Idle")e
	else:
		shoot_sequencial=false
		first_shoot=true
	pass
			
func hit_points(enemy_pos,damage):
	life_bar -= damage
	#print(life_bar)
	damage_taken=true 
	
	$Invinicibility.start()
	if life_bar <= 0:
		print('game_over')

		yield(get_tree().create_timer(1), "timeout")
		get_tree().reload_current_scene()

	else:
		Global.invincibility = true  
		$Pisca.start()
	pass



func _on_RestShoot_timeout():
	shoot_sequencial=true
	pass # Replace with function body.


func _on_InBetweenShoot_timeout():
	$InBetweenShoot.wait_time=0.15
	first_shoot=true
	pass # Replace with function body.


func _on_Invinicibility_timeout():
	$Invinicibility.stop() 
	$Pisca.stop()
	Global.invincibility = false 
	$Sprite.visible=true
	pass # Replace with function body.


func _on_Pisca_timeout():  
	print("ENTROU")
	$Pisca.wait_time=0.15 
	if($Sprite.visible==false):
		$Sprite.visible=true
	elif($Sprite.visible==true):
		$Sprite.visible=false  
		
	pass # Replace with function body.
