extends PlayerState

func enter(msg := {}) -> void:
	print('entered run')


func physics_update(delta: float) -> void:
	player.animation_mode.play("Ball")
	
	player.collision.scale.y = 0.4
	player.collision.scale.x = 0.7
	
	.player_run(delta)
	
	if Input.is_action_pressed("up"):
		player.collision.scale.y = 1
		player.collision.scale.x = 1
		state_machine.transition_to("Idle")
