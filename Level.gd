extends Node


@export var player_scene: PackedScene
@export var monster_scene: PackedScene
@export var map_scene: PackedScene

signal player_death

@onready
var camera = $Camera2D
var map: Node2D

func purge():
	camera.reparent(self)
	for node in $Characters.get_children():
		node.hide()
		node.queue_free()
	for node in $Monsters.get_children():
		node.hide()
		node.queue_free()
	if map:
		map.hide()
		map.queue_free()
	
func get_players():
	return $Characters

func create():
	get_tree().paused = true
	print('creating game')
	map = map_scene.instantiate()
	map.z_index = -10
	add_child(map)
	var player
	for id in multiplayer.get_peers():
		player = player_scene.instantiate()
		player.player = id
		player.connect('dead', _on_player_death)
		$Characters.add_child(player, true)
	player = player_scene.instantiate()
	player.player = 1
	player.connect('dead', _on_player_death)
	$Characters.add_child(player, true)
	var monster = monster_scene.instantiate()
	monster.set_player(player.player)
	monster.set_multiplayer_authority(1)
	$Monsters.add_child(monster)
	$MobSpawnTimer.start()
	#$Camera2D.reparent(player)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _on_player_death():
	print('player death!')
	player_death.emit()


func _on_mob_spawn_timer_timeout():
	pass # Replace with function body.
