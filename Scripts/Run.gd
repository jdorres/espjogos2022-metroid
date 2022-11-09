# Air.gd
extends PlayerState


# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	print('entered run')


func physics_update(delta: float) -> void:
	player.animation_mode.travel("Running")
	if not player.is_on_floor():
		state_machine.transition_to("Jump")
		return

	var input_direction_x: float = (
		Input.get_action_strength("right")
		- Input.get_action_strength("left")
	)
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if input_direction_x != 0:
		player.player.scale.x = input_direction_x

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("JumpRolling", {do_jump = true})
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
