
extends PlayerState

func enter(_msg := {}) -> void:
	print('entered idle shooting')

func update(delta: float) -> void:
	print('update idle shooting')
