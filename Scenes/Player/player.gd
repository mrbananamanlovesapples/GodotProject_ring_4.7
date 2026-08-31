extends CharacterBody2D
@onready var item = preload("res://Scenes/Player/item.tscn")
@onready var RingPath = get_node("Node2D/RingPath")
var speed := 200.0
var accel := 10.0   # how quickly the player reaches full speed
var friction := 4.0 # how quickly the player slows down
func _ready() -> void:
	pass
func _physics_process(delta: float) -> void:
	if velocity.x < 5 && velocity.x > -5 && velocity.y < 5 && velocity.y > -5:
		$Particles/CloudParticles.emitting = false
	else:
		$Particles/CloudParticles.emitting = true
	GV.PlayerPos = global_position
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("w"):
		input_vector.y -= 1
	if Input.is_action_pressed("s"):
		input_vector.y += 1
	if Input.is_action_pressed("a"):
		input_vector.x -= 1
	if Input.is_action_pressed("d"):
		input_vector.x += 1
		input_vector = input_vector.normalized()

	# Smooth acceleration
	if input_vector != Vector2.ZERO:
		velocity = velocity.lerp(input_vector * speed, accel * delta)
	else:
		# Smooth deceleration (friction)
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)

	move_and_slide()
	#Current player movement for test purposes only-----------------
	#want the player to have smooth movement as they are sat on a cloud
	animations()

func animations():
	CloudBobbing()

func CloudBobbing():
	var param = 10
	var MoveAmount = .1
	var sprite := get_node("Floatingstickman")
	var t : float = Time.get_ticks_msec() / 1000.0
	var amplitude : float = param 
	var speed := 2.0   # higher = faster bobbing
	sprite.position.y = sin(t * speed) * amplitude

	#Clamp and flip direction--------------------
	if sprite.position.y >= param:
		sprite.position.y = param
		MoveAmount = -abs(MoveAmount)

	elif sprite.position.y <= -param:
		sprite.position.y = -param
		MoveAmount = abs(MoveAmount)
	#Apply movement-------------
	sprite.position.y += MoveAmount
	#Reused Item bobbing code-----------
