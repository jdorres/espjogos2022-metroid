class_name Jump
extends PlayerState

# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_speed
	pass

func physics_update(delta: float) -> void:
	player.animation_mode.play("Jumping")
	.player_jump(delta)

	if player.is_on_floor():
		state_machine.transition_to("Idle")
