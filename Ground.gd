extends TileMap

@export var size = 100



# Called when the node enters the scene tree for the first time.
func _ready():
	var arr = PackedVector2Array()
	for i in range(size):
		for n in range(size):
			arr.append(Vector2(i - 1, n - 1))
			
	set_cells_terrain_connect(0, arr, 0, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
