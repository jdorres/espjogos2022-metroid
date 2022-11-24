# Air.gd
extends PlayerState


# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	print('entered run')


func physics_update(delta: float) -> void:
	#player.animation_mode.play("Run")
	player.get_node("Sprite").play("running");
	.player_run(delta)
	
	if not player.is_on_floor():
		state_machine.transition_to("Jump")
		return
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("JumpRolling", {do_jump = true})
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("up"):
		state_machine.transition_to("RunPointingUp")
