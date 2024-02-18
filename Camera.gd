extends Camera2D

var players: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	players = get_parent().get_players()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var players = players.get_children()
	if not players.size():
		return
	var average_x = players.map(func(p): return p.position.x)
	average_x = average_x.reduce(sum) 
	average_x = average_x / players.size() 
	var average_y = players.map(func(p): return p.position.y).reduce(sum) / players.size()
	
	position = Vector2(average_x, average_y)

func sum(m, x):
	return m + x
