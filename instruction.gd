extends Node2D

@onready var pickupSound = $PickupSound
var variance = 1.0
var is_held = false
var able_to_be_held = false 
	#used to dynamically turn on or off ability to be picked up, such as being turned off if something else is held.
var unlocked = true 
	#hard shut down it from moving, like if an instruction is left there for a puzzle, or at end of level
var offset: Vector2
var blockname = "TEST"
var spawnpoint
var y_boundry = 645
var x_boundry = 1150
var snap_to_location
var in_slot = false
var slot
#func _on_area_2d_mouse_entered(): #obselete can be deleted
	#if not global.is_dragging:
		#able_to_be_held = true
		##print(blockname+ ": is able to be held")
	#$Area2D/Label.text = "["+blockname+"]"

func set_spawnpoint(proposedspawnpoint):
	spawnpoint = proposedspawnpoint
	
func is_instruction():
	pass
func go_home():
	if slot != null:
		if slot.instructions.size()>0:
			slot.instructions.pop_front()
	else:
		slot = null
	#snap_to_location = spawnpoint
	global_position = spawnpoint


func _process(delta):
	if able_to_be_held:
		if Input.is_action_just_pressed("click"):
			pickupSound.attenuation= randf_range(0.2,6.0)
			pickupSound.pitch_scale= randf_range(1.10,1.50)
			pickupSound.play()
			#global.add_text_to_dot_matrix("I just clicked the thingy!")
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true
			z_index = 99
			if slot != null:
				if slot.instructions.size()>0:
					slot.instructions.pop_front()
		if Input.is_action_pressed("click"):
			global_position=get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			z_index = 1
			if slot != null:
				# TODO move this where it should actually go
				#global.nuke_dot_matrix()
				slot.instructions.append(self)
				print(slot.instructions.size())
			if slot != null and slot.instructions.size()>1:
				slot.eject()
				global_position=snap_to_location
			elif slot != null:
				global_position=snap_to_location
				
			else:
				go_home()
		#STAY INSIDE THE BOX YE BASTARD!!!!
		if global_position.y > y_boundry:
			global_position.y = y_boundry
		if global_position.y < global.border.y:
			global_position.y = global.border.y
		if global_position.x > x_boundry:
			global_position.x = x_boundry
		#if global_position.x < -5:
			#global_position.x = 0
func givename(proposedname):
	blockname = proposedname
	%Label.text = proposedname

func _on_mouse_entered():
	if not global.is_dragging:
		able_to_be_held = true
		#print(blockname+ ": is able to be held from mouse entering")
		#$Label.text = blockname.to_upper()


func _on_mouse_exited():
	if not global.is_dragging:
		able_to_be_held = false
		#printerr(blockname+ ": is not able to be held from mouse exiting")
		$Label.text = blockname.to_lower()


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if not area.has_method("is_instruction"):
		slot = area
		#print(str("NOW ENTERING SLOT: "+ str(area.slot_number)))
	pass
