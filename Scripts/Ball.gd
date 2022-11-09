extends PlayerState

func enter(msg := {}) -> void:
	print('entered run')


func physics_update(delta: float) -> void:
	player.animation_mode.travel("Ball")
	
	player.collision.scale.y = 0.4
	player.collision.scale.x = 0.7

	var input_direction_x: float = (
		Input.get_action_strength("right")
		- Input.get_action_strength("left")
	)
	
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if input_direction_x != 0:
		player.player.scale.x = input_direction_x
	
	if Input.is_action_pressed("up"):
		player.collision.scale.y = 1
		player.collision.scale.x = 1
		state_machine.transition_to("Idle")
