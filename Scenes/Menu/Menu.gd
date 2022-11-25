extends Control

var blink = 0

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		$Timer.start()

func _on_StartButton_pressed() -> void:
	$Timer.start()

func _on_Timer_timeout() -> void:
	blink += 1
	$StartButton.visible = not $StartButton.visible
	if blink > 10:
		get_tree().change_scene("res://Scenes/GameController.tscn")
