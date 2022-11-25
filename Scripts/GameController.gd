extends Node2D

func _ready() -> void:
	$GameOverTimer.connect("timeout", self, "reload")
	$GameOverTimer.set_wait_time(1)

func _physics_process(_delta: float) -> void:
	check_game_over()

func check_game_over() -> void:
	if Global.player_life_points < 1:
		if $GameOverTimer.is_stopped():
			$GameOverTimer.start()

func reload() -> void:
	Global.player_life_points = 30
	Global.invincibility = false
	get_tree().reload_current_scene()


