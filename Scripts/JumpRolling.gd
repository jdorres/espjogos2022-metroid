# Run.gd
extends PlayerState

# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	print('entered jump rolling')
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_speed

func physics_update(delta: float) -> void:
	player.animation_mode.play("JumpingRoll")
	
	.player_jump(delta)
	
	if player.is_on_floor():
		state_machine.transition_to("Idle")
