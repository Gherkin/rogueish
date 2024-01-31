extends Area2D

@export var explosion_scene: PackedScene
@export var velocity = Vector2.ZERO
@export var speed = 400


# Called when the node enters the scene tree for the first time.
func _ready():
	$TravelTimer.start()
	$projectile/AnimatedSprite2D.animation = "travel"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_mode = Node.PROCESS_MODE_PAUSABLE
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	if $TravelTimer.is_stopped() and $explosions.get_child_count() == 0:
		hide()
		queue_free()
	position += velocity * delta

func spawn_explosion(x_offset, y_offset):
	var explosion = explosion_scene.instantiate()
	
	var round_pos = snapped(position, Vector2(32, 32))
	
	explosion.position = Vector2(x_offset + round_pos.x - position.x, y_offset + round_pos.y - position.y)
	$explosions.add_child(explosion)
	
func circle_explosion(size):
	var n = 0
	for i in range(-1 * (size - 1) / 2, 0):
		var len_row = n * 2 + 1
		for k in range(-1 * (len_row - 1) / 2,  (len_row - 1) / 2 + 1):
			spawn_explosion(k * 32, i * 32)
		n += 1
	for i in range(-1 * (size - 1) / 2,  (size - 1) / 2 + 1):
		spawn_explosion(i * 32, 0)
	n = (size - 1) / 2 - 1
	for i in range(1, (size - 1) / 2 + 1):
		var len_row = n * 2 + 1
		for k in range(-1 * (len_row - 1) / 2,  (len_row - 1) / 2 + 1):
			spawn_explosion(k * 32, i * 32)
		n -= 1
		

func _on_timer_timeout():
	velocity = Vector2.ZERO
	rotation = 0
	$projectile.hide()
	circle_explosion(7)
	#$AnimatedSprite2D.animation = "explode"
	#$ExplodeTimer.start()


func _on_explode_timer_timeout():
	#queue_free()
	pass
