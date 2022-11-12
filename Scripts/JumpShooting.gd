class_name JumpShooting
extends Jump

func enter(_msg := {}) -> void:
	#parent method
	.enter()
	print('entered idle shooting')

func update(delta: float) -> void:
	#parent method
	.update(delta)
	print('update idle shooting')
