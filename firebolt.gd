extends Area2D

@export var explosion_scene: PackedScene
@export var velocity = Vector2.ZERO
@export var speed = 400


# Called when the node enters the scene tree for the first time.
func _ready():
	$TravelTimer.start()
	$AnimatedSprite2D.animation = "travel"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	if $TravelTimer.is_stopped() and $explosions.get_child_count() == 0:
		print('yo')
		hide()
	#	queue_free()
	position += velocity * delta


func _on_timer_timeout():
	velocity = Vector2.ZERO
	rotation = 0
	var explosion = explosion_scene.instantiate()
	explosion.rotation = 0
	explosion.position = Vector2.ZERO
	$explosions.add_child(explosion)
	#$AnimatedSprite2D.animation = "explode"
	#$ExplodeTimer.start()


func _on_explode_timer_timeout():
	#queue_free()
	pass
