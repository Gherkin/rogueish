extends CanvasLayer

var paused := false
var started := false

@rpc("call_local", "any_peer")
func unpause():
	print('unpaused')
	hide()
	get_tree().paused = false
	paused = false
	
@rpc("any_peer", 'call_local')
func pause():
	print(str(multiplayer.get_unique_id()) + ' paused')
	show()
	get_tree().paused = true
	paused = true
	
func _unhandled_input(event):
	if not started:
		return
	if !event is InputEventKey:
		return
	if !(event.pressed and event.keycode == KEY_ESCAPE):
		return
	if paused:
		unpause.rpc()
	else:
		pause.rpc()

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
