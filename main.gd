extends Node

@export var player_scene: PackedScene
@export var map_scene: PackedScene


func create_game():
	var player = player_scene.instantiate()
	var map = map_scene.instantiate()
	
	$Camera2D.reparent(player)
	add_child(map)
	add_child(player)
	$MainMenu.hide()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_menu_start_game():
	create_game()
