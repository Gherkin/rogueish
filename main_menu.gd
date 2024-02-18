extends CanvasLayer

signal start_game
signal host
signal connect


# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	start_game.emit()


func _on_connect_pressed():
	connect.emit()


func _on_host_pressed():
	host.emit()
