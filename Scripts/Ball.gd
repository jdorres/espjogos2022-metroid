extends PlayerState

func enter(msg := {}) -> void:
	print('entered run')


func physics_update(delta: float) -> void:
	#player.animation_mode.play("Ball")
	player.get_node("Sprite").play("down");
	
	#player.collision.scale.y = 0.4
	#player.collision.scale.x = 0.7
	player.get_node("Down").disabled=false
	player.get_node("Stand").disabled=true
	.player_run(delta)
	
	if Input.is_action_pressed("up") and player.get_node("RayCast2D").is_colliding()==false: 
		player.get_node("Down").disabled=true
		player.get_node("Stand").disabled=false
		state_machine.transition_to("Idle")
		player.get_node("Sprite").play("idle")
