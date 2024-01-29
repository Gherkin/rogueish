extends Area2D

@export var speed = 400
@export var firebolt_scene: PackedScene
@export var projectile_offset = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$AnimatedSprite2D.play()
	$RateOfFire.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("click") and $RateOfFire.is_stopped():
		_on_rate_of_fire_timeout()
		$RateOfFire.start()
	elif not Input.is_action_pressed("click") and not $RateOfFire.is_stopped():
		$RateOfFire.stop()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta


func _on_rate_of_fire_timeout():
	if not Input.is_action_pressed("click"):
		return
	
	var firebolt = firebolt_scene.instantiate()
	firebolt.position = position.move_toward(get_global_mouse_position(), projectile_offset)
	#var direction = randf_range(-PI, PI)
	var direction = position.angle_to_point(get_global_mouse_position())
	firebolt.velocity = (get_global_mouse_position() - position).normalized()
	firebolt.rotation = direction
	
	$projectiles.add_child(firebolt)


