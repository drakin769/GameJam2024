extends Node2D
func _ready():
	print(get_parent().global_position)
	global.border = get_parent().global_position
