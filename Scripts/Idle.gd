class_name Idle
extends PlayerState

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	print('entered idle')
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	player.velocity = Vector2.ZERO


func update(delta: float) -> void:
	print('update idle')
	player.animation_mode.travel("Idle")
	
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	if not player.is_on_floor():
		state_machine.transition_to("Jump")
		return

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump", {do_jump = true})
	elif Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state_machine.transition_to("Run")
	elif Input.is_action_pressed("down"):
		state_machine.transition_to("Ball")
	elif Input.is_action_pressed("up"):
		state_machine.transition_to("IdleShootingUp")
