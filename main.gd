extends Node

@export var player_scene: PackedScene
@export var map_scene: PackedScene

const PORT = 4433

func start_game():
	$MainMenu.hide()
	
func create_game():
	var player = player_scene.instantiate()
	var map = map_scene.instantiate()
	
	$Camera2D.reparent(player)
	$Level.add_child(map)
	$Level.add_child(player)
	start_game()
	#get_tree().paused = false
	

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.server_relay = false
	#get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_menu_start_game():
	create_game()


func _on_main_menu_connect():
	print('connecting')
	# Start as client.
	var txt : String = $MainMenu/ip.text
	if txt == "":
		OS.alert("Need a remote to connect to.")
		return
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(txt, PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
		return
	multiplayer.multiplayer_peer = peer
	start_game()



func _on_main_menu_host():
	print('hosting')
	# Start as server.
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return
	multiplayer.multiplayer_peer = peer
	create_game()
