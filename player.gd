extends Area2D

@export var speed = 400
@export var firebolt_scene: PackedScene
@export var projectile_offset = 50

@export var player := 1 :
	set(id):
		player = id
		# Give authority over the player input to the appropriate peer.
		$PlayerInputSynchronizer.set_multiplayer_authority(id)

@onready var input = $PlayerInputSynchronizer

var velocity = Vector2.ZERO



# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	$RateOfFire.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	velocity = Vector2.ZERO
	if input.right:
		velocity.x += 1
	if input.left:
		velocity.x -= 1
	if input.down:
		velocity.y += 1
	if input.up:
		velocity.y -= 1

	if input.click and $RateOfFire.is_stopped():
		_on_rate_of_fire_timeout()
		$RateOfFire.start()
	elif not input.click and not $RateOfFire.is_stopped():
		$RateOfFire.stop()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta

@rpc('call_local', 'any_peer')
func create_firebolt(player_pos, mouse_pos):
	var firebolt = firebolt_scene.instantiate()
	var direction = player_pos.angle_to_point(mouse_pos)
	
	firebolt.position = player_pos.move_toward(mouse_pos, projectile_offset)
	firebolt.rotation = direction
	firebolt.velocity = (mouse_pos - player_pos).normalized()
	
	$projectiles.add_child(firebolt)

func _on_rate_of_fire_timeout():
	if not input.click:
		return
	
	create_firebolt.rpc(position, get_global_mouse_position())



