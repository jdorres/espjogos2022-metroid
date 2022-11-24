class_name JumpShootingUp
extends PlayerState

func enter(msg := {}) -> void:
	print('entered jump pointing up')
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_speed

func update(delta: float) -> void:
	print('update jump pointing up')
	#player.animation_mode.play("JumpPointingUp")
	player.get_node("Sprite").play("jumpPointUp")
	.player_jump(delta)
	
	if player.is_on_floor() and Input.is_action_pressed("up"):
		state_machine.transition_to("IdlePointingUp")
	elif player.is_on_floor() and not Input.is_action_pressed("up"):
		state_machine.transition_to("Idle")

