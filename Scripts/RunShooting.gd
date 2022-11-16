
extends PlayerState

func enter(_msg := {}) -> void:
	print('entered run shooting')

func update(delta: float) -> void:
	print('update run shooting')
	player.animation_mode.play('RunShooting')

	.player_run(delta)
	
	if Input.is_action_just_released('up'):
		state_machine.transition_to("Run")
	elif Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		state_machine.transition_to("IdlePointingUp")
