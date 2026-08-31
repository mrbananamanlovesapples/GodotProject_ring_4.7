extends CharacterBody2D
@onready var item = preload("res://Scenes/Player/item.tscn")
@onready var RingPath = get_node("Node2D/RingPath")
func _ready() -> void:
	pass
func _physics_process(delta: float) -> void:
	GV.PlayerPos = global_position
	if Input.is_action_pressed("w"):
		global_position.y -= 1
	elif Input.is_action_pressed("s"):
		global_position.y += 1
	if Input.is_action_pressed("a"):
		global_position.x -= 1
	elif Input.is_action_pressed("d"):
		global_position.x += 1
	#Current player movement for test purposes only-----------------
