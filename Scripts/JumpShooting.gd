class_name JumpShooting
extends PlayerState

func enter(msg := {}) -> void:
	print('entered jump shooting')
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_speed

func update(delta: float) -> void:
	print('update jump shooting')
