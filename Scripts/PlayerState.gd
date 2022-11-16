# Boilerplate class to get full autocompletion and type checks for the `player` when coding the player's states.
# Without this, we have to run the game to see typos and other errors the compiler could otherwise catch while scripting.
class_name PlayerState
extends State

# Typed reference to the player node.
var player: Player
var input_direction_x

func _ready() -> void:
	# The states are children of the `Player` node so their `_ready()` callback will execute first.
	# That's why we wait for the `owner` to be ready first.
	yield(owner, "ready")
	# The `as` keyword casts the `owner` variable to the `Player` type.
	# If the `owner` is not a `Player`, we'll get `null`.
	player = owner as Player
	# This check will tell us if we inadvertently assign a derived state script
	# in a scene other than `Player.tscn`, which would be unintended. This can
	# help prevent some bugs that are difficult to understand.
	assert(player != null)

func player_run(delta):
	input_direction_x  = (
		Input.get_action_strength("right")
		- Input.get_action_strength("left")
	)
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if input_direction_x > 0:
		player.sprite.flip_h = false
	elif input_direction_x < 0:
		player.sprite.flip_h = true
		

func player_jump(delta):
	print('player jump')
	input_direction_x = (Input.get_action_strength("right") - Input.get_action_strength("left"))
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if input_direction_x > 0:
		player.sprite.flip_h = false
	elif input_direction_x < 0:
		player.sprite.flip_h = true
