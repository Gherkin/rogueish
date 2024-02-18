extends Area2D

@export var speed = 400
@export var following_player: int
var enemy := true
@export var dmg := 0

var velocity = Vector2.ZERO
var players = []

var touching_players = []

func set_player(player: int):
	self.following_player = player
	
func find_nearest_player():
	players.sort_custom(
		func(a, b): 
			return position.distance_to(a.position) < position.distance_to(b.position)
	)
	set_player(players[0].player)
# Called when the node enters the scene tree for the first time.
func _ready():
	players = get_parent().get_parent().get_players().get_children()
	if get_multiplayer_authority() == multiplayer.get_unique_id():
		print('connecting signals')
		self.connect('area_entered', _on_area_entered)
		self.connect('area_exited', _on_area_exited)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for player in touching_players:
		player.inflict_dmg(dmg)
	
	find_nearest_player()
	
	var player = players.filter(func(node): return node.player == following_player)[0]
	velocity = player.position - position
	if abs(velocity.angle()) > PI/2:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	



func _on_area_entered(area):
	print('entered')
	if 'player' in area and area.player:
		touching_players.append(area)


func _on_area_exited(area):
	print('exited')
	if area in touching_players:
		touching_players.erase(area)
