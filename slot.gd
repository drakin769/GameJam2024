extends Node2D
#var is_held = false
#var able_to_be_held = false 
	#used to dynamically turn on or off ability to be picked up, such as being turned off if something else is held.
var unlocked = true 
	#hard shut down it from moving, like if an instruction is left there for a puzzle, or at end of level
var offset: Vector2
var blockname = "TEST"
var spawnpoint
var y_boundry = 645
var x_boundry = 1150
var occupied = false
var instructions = []
var number_overlapping
#
#func _on_area_2d_mouse_entered():
	#if not global.is_dragging:
		#able_to_be_held = true
	#$Area2D/Label.text = "*"+blockname+"*"

func set_spawnpoint(proposedspawnpoint):
	spawnpoint = proposedspawnpoint

#
#func _on_area_2d_mouse_exited():
	#if not global.is_dragging:
		#able_to_be_held = false
	#$Area2D/Label.text = blockname

func _process(delta):
	pass
	#if able_to_be_held:
		#if Input.is_action_just_pressed("click"):
			#offset = get_global_mouse_position() - global_position
			#global.is_dragging = true
		#if Input.is_action_pressed("click"):
			#global_position=get_global_mouse_position() - offset
		#elif Input.is_action_just_released("click"):
			#global.is_dragging = false
			#
		##STAY INSIDE THE BOX YE BASTARD!!!!
		#if global_position.y > y_boundry:
			#global_position.y = y_boundry
		#if global_position.y < global.border.y:
			#global_position.y = global.border.y
		#if global_position.x > x_boundry:
			#global_position.x = x_boundry
		#if global_position.x < 0:
			#global_position.x = 0
func givename(proposedname):
	blockname = proposedname


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	instructions.append(area)
	#instruction.slot = self
	#if not instructions.is_empty:
		#occupied = true
		#print("occupied = true")
	instructions[0].in_slot= true
	instructions[0].snap_to_location = global_position


func _on_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if instructions[0] == area:
		if instructions[0].has_method("is_instruction"):
			occupied = false
			print("occupied = false")
			instructions[0].in_slot= false
		instructions.pop_front()
