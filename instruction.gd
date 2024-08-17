extends Node2D
var is_held = false
var able_to_be_held = false 
	#used to dynamically turn on or off ability to be picked up, such as being turned off if something else is held.
var unlocked = true 
	#hard shut down it from moving, like if an instruction is left there for a puzzle, or at end of level
var offset: Vector2
var blockname = "TEST" 
var number: int = 0

func _on_area_2d_mouse_entered():
	if not global.is_dragging:
		able_to_be_held = true
	$Area2D/Label.text = "*"+blockname+"*"


func _on_area_2d_mouse_exited():
	if not global.is_dragging:
		able_to_be_held = false
	$Area2D/Label.text = blockname

func _process(delta):
	if able_to_be_held:
		if Input.is_action_just_pressed("click"):
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position=get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			
func givename(proposedname):
	blockname = proposedname
