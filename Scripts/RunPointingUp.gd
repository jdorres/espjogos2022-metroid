
extends PlayerState

func enter(_msg := {}) -> void:
	print('entered run shooting up')

func update(delta: float) -> void:
	print('update run shooting up')
	player.animation_mode.play('RunPointingUp')

	.player_run(delta)
	
	if Input.is_action_just_released('up'):
		state_machine.transition_to("Run")
	elif Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		state_machine.transition_to("IdlePointingUp")
	elif Input.is_action_just_pressed("jump"):
		state_machine.transition_to("JumpRolling", {do_jump = true})
