extends Node


@export var player_scene: PackedScene
@export var map_scene: PackedScene

func create():
	print('creating game')
	var player
	for id in multiplayer.get_peers():
		player = player_scene.instantiate()
		player.player = id
		$Characters.add_child(player, true)
	player = player_scene.instantiate()
	player.player = 1
	$Characters.add_child(player, true)
	var map = map_scene.instantiate()
	get_tree().paused = true
	#$Camera2D.reparent(player)
	add_child(map)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
