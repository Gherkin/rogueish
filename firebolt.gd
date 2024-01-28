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
	position += velocity * delta


func _on_timer_timeout():
	$AnimatedSprite2D.animation = "explode"
	velocity = Vector2(0, 0)
	rotation = 0
	$ExplodeTimer.start()


func _on_explode_timer_timeout():
	queue_free()
