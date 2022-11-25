class_name HUD
extends CanvasLayer

onready var life_points_label := $Control/LifePointsLabel 

func _process(delta: float) -> void:
	life_points_label.text = str(Global.player_life_points)
