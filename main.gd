extends Node

@onready var current_menu = $MainMenu


const PORT = 4433

@rpc('call_local')
func start_game():
	print('starting game')
	current_menu.hide()
	get_tree().paused = false

@rpc("call_local", "any_peer")
func pause():
	print('paused')
	get_tree().paused = true

@rpc("call_local", "any_peer")
func unpause():
	print('unpaused')
	get_tree().paused = false

func open_lobby():
	$MainMenu.hide()
	$LobbyMenu.show()
	current_menu = $LobbyMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.server_relay = false
	$LobbyMenu.hide()
	#get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_main_menu_start_game():
	$Level.create()
	start_game()


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
	open_lobby()

func _on_peer_connected(id):
	print('connected!')
	$LobbyMenu/Label.text = str(id)

func _on_main_menu_host():
	print('hosting')
	# Start as server.
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	peer.connect("peer_connected", _on_peer_connected)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return
	multiplayer.multiplayer_peer = peer
	open_lobby()


func _on_lobby_menu_lobby_start():
	$Level.create()
	start_game.rpc()
