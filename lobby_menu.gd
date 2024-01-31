extends CanvasLayer

signal lobby_start

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not multiplayer.is_server():
		$Button.hide()
		$Label.text = 'WAITING FOR HOST TO START!'

func _on_button_pressed():
	lobby_start.emit()

func _on_peer_connected(id):
	print('connected!')
	$Label.text = str(id)
