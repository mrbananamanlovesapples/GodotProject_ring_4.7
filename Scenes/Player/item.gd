extends PathFollow2D

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	Animations()

var param = 3
var MoveAmount = .01
@export var Offset = 100.0
func Animations():
	var child := get_child(0)
	var t : float = (Time.get_ticks_msec() + Offset) / 1000.0
	var amplitude : float = param 
	var speed := 2.0   # higher = faster bobbing
	get_child(0).position.y = sin(t * speed) * amplitude

	# --- Clamp and flip direction ---
	if child.position.y >= param:
		child.position.y = param
		MoveAmount = -abs(MoveAmount)

	elif child.position.y <= -param:
		child.position.y = -param
		MoveAmount = abs(MoveAmount)
	# --- Apply movement ---
	child.position.y += MoveAmount
