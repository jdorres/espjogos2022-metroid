class_name IdleShootingUp
extends Idle

func enter(_msg := {}) -> void:
	print('entered idle shooting up')

func update(delta: float) -> void:
	#parent method
	.update(delta)
	print('update idle shooting up')
