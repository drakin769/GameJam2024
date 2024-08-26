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
var color_offset = 0.6
var shaded = true
var flash = false
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
		slot.eject(str(blockname, "is going home"))

	else:
		slot = null
	#snap_to_location = spawnpoint
	global_position = spawnpoint
	if not shaded:
		$Sprite2D.self_modulate=$Sprite2D.self_modulate.darkened(color_offset)
		shaded=true
func _ready():
	$Sprite2D.self_modulate=$Sprite2D.self_modulate.darkened(color_offset)
	snap_to_location = spawnpoint

func _process(delta):
	if Input.is_action_just_pressed("click"):
		print_all()
	if (able_to_be_held or flash) and unlocked == true:
		if Input.is_action_just_pressed("click"):#picked up
			pickupSound.attenuation= randf_range(0.2,6.0)
			pickupSound.pitch_scale= randf_range(1.10,1.50)
			pickupSound.play()
			#global.add_text_to_dot_matrix("I just clicked the thingy!")
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true
			z_index = 99
			if slot != null:
				slot.eject("Mouse is repressed")
				slot=null
		if Input.is_action_pressed("click"):
			global_position=get_global_mouse_position() - offset
			if global_position.y > y_boundry:
				global_position.y = y_boundry
			if global_position.y < global.border.y:
				global_position.y = global.border.y
			if global_position.x > x_boundry:
				global_position.x = x_boundry
			if global_position.x < -5:
				global_position.x = 0
		elif Input.is_action_just_released("click"):
			
			if global_position != snap_to_location:
				#able_to_be_held = false
				go_home()
				#global_position = snap_to_location
			else:
				flash = true
			global.is_dragging = false
			z_index = 1

			if slot != null: #and slot.instructions.size()>1:
				slot.add_block(self)
				if shaded == true:
					lighten()
					shaded= false
				global_position = snap_to_location
	elif able_to_be_held == false and slot== null:
		go_home()
		#STAY INSIDE THE BOX YE BASTARD!!!!
		if global_position.y > y_boundry:
			global_position.y = y_boundry
		if global_position.y < global.border.y:
			global_position.y = global.border.y
		if global_position.x > x_boundry:
			global_position.x = x_boundry
		if global_position.x < -5:
			global_position.x = 0
	else:
		global_position = snap_to_location
func givename(proposedname):
	blockname = proposedname
	%Label.text = proposedname
	

func _on_mouse_entered():
	if not global.is_dragging and unlocked == true:
		able_to_be_held = true
		#print(blockname+ ": is able to be held from mouse entering")
		#$Label.text = blockname.to_upper()


func _on_mouse_exited():
	if not global.is_dragging:
		able_to_be_held = false
		flash=false
		#printerr(blockname+ ": is not able to be held from mouse exiting")


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if not area.has_method("is_instruction"):
		if area.unlocked == true or (area.unlocked == false and unlocked == false and global.level_lock == false):
			slot = area
			if unlocked == false:
				area.unlocked = false
			print(str("NOW ENTERING SLOT: "+ str(area.slot_number)))
	pass
func print_all():
		print("instruction, blockname: ",blockname," is held: ", is_held, " able to be held ", able_to_be_held," unlocked ", unlocked		)
		print("slot: ", slot)
		print("flash",flash)
func lighten():
	$Sprite2D.self_modulate=$Sprite2D.self_modulate.lightened(color_offset)


func _on_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	#slot = null
	#snap_to_location = spawnpoint 
	pass
