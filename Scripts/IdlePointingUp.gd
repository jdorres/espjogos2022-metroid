class_name IdleShootingUp
extends PlayerState

func enter(_msg := {}) -> void:
	print('entered idle pointing up')

func update(delta: float) -> void:
	print('update idle pointing up')
	#player.animation_mode.play("IdlePointingUp")
	player.get_node("Sprite").play("idleUp")
	if Input.is_action_just_released('up'):
		state_machine.transition_to("Idle")
	elif Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state_machine.transition_to("RunPointingUp")
	elif Input.is_action_just_pressed("jump"):
		state_machine.transition_to("JumpPointingUp", {do_jump = true})
	
