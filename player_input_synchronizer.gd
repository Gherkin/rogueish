extends MultiplayerSynchronizer

@export var up := false
@export var right := false
@export var left := false
@export var down := false

enum Inputs {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

# Called when the node enters the scene tree for the first time.
func _ready():
	print(str(get_multiplayer_authority()) + ' ' +  str(multiplayer.get_unique_id()))
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())

@rpc("call_local")
func button_pressed(input):
	print(get_multiplayer_authority())
	match input:
		Inputs.UP:
			up = true
		Inputs.DOWN:
			down = true
		Inputs.LEFT:
			left = true
		Inputs.RIGHT:
			right = true

@rpc("call_local")
func button_released(input):
	match input:
		Inputs.UP:
			up = false
		Inputs.DOWN:
			down = false
		Inputs.LEFT:
			left = false
		Inputs.RIGHT:
			right = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !up and Input.is_action_pressed("up"):
		button_pressed.rpc(Inputs.UP)
	elif up and !Input.is_action_pressed("up"):
		button_released.rpc(Inputs.UP)
	if !down and Input.is_action_pressed("down"):
		button_pressed.rpc(Inputs.DOWN)
	elif down and !Input.is_action_pressed("down"):
		button_released.rpc(Inputs.DOWN)
	if !left and Input.is_action_pressed("left"):
		button_pressed.rpc(Inputs.LEFT)
	elif left and !Input.is_action_pressed("left"):
		button_released.rpc(Inputs.LEFT)
	if !right and Input.is_action_pressed("right"):
		button_pressed.rpc(Inputs.RIGHT)
	elif right and !Input.is_action_pressed("right"):
		button_released.rpc(Inputs.RIGHT)
