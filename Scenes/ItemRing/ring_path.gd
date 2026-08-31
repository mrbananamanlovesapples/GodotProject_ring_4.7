extends Path2D
@onready var item = preload("res://Scenes/Player/item.tscn")
@onready var RingPath = get_node("Node2D/RingPath")
func _ready() -> void:
	pass
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("e"):
		var itemInstance = item.instantiate()
		add_child(itemInstance)
		itemInstance.Offset = get_child_count() * 500
		resetitemsinring()
	rotatering()
	FollowPlayer()
func FollowPlayer():
	var Fspeed = .2
	global_position.x += (GV.PlayerPos.x - global_position.x) * Fspeed
	global_position.y += (GV.PlayerPos.y - global_position.y) * Fspeed #Ring follows player with a delay/lag 
func resetitemsinring():
	var distance = 100/(get_child_count())
	for i in get_child_count():
		get_child(i).progress = distance * i #Equally sets distance between each item in the ring
func rotatering():
	for i in get_child_count(): # repeats for each child of the path (children are followpath nodes)
		if get_child(i) != null:
			#///making sure there is a child
			if get_child(i).global_position.y >= GV.PlayerPos.y + 4:
				print("sdfsdf")
				if get_child(i).progress > 50:
					get_child(i).z_index = 100 - get_child(i).progress
				else:
					get_child(i).z_index = get_child(i).progress
			else:
				print("s3333")
				get_child(i).z_index = -1
			#setting z index releative to its position so its hidden behind player and goes behind or infront each other
			get_child(i).progress += .05 #moves it around circle
