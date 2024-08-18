extends Node2D
var col_1 = 100
var col_2 = 320
var col_3 = 650
var col_4 = 970
var instruction_spawn_point = [
			Vector2(col_1 ,350),Vector2(col_1 ,420),
			Vector2(col_1,490),Vector2(col_1 ,560),
			Vector2(col_1,630),Vector2(col_2 ,350),
			Vector2(col_2 ,420),Vector2(col_2,490),
			Vector2(col_2 ,560),Vector2(col_2,630),
			]
var slot_spawn_point = [
			Vector2(col_3 ,350),Vector2(col_4 ,350),
			Vector2(col_3 ,420),Vector2(col_4 ,420),
			Vector2(col_3 ,490),Vector2(col_4 ,490),
			Vector2(col_3 ,560),Vector2(col_4 ,560),
			Vector2(col_3 ,630),Vector2(col_4 ,630),
			]
var instruction_counter = 0
var slot_counter = 0
var level = 1
var nanopacket = []
var block_box = []
var available_solutions

func clear_nanopacket():
	while not nanopacket.is_empty():
		nanopacket.pop_front().queue_free()
func clear_block_box():
	while not block_box.is_empty():
		block_box.pop_front().queue_free()
			
func run_nanopacket():
	var nanonumber = 0
	var output:String
	print("RUNNING NANOPACKET")
	while nanonumber < nanopacket.size():
		print("Running Slot "+ str(nanopacket[nanonumber].slot_number)+": "+nanopacket[nanonumber].content())
		output+=nanopacket[nanonumber].content()
		nanonumber+=1
		if nanonumber <nanopacket.size():
			output+=":"
	print("ENDING NANOPACKET")
	print("Nanopacket is:" + output)
	return output
func _ready():
	setlevel()
	
func _process(delta):
	if Input.is_action_just_pressed("q") and OS.is_debug_build():
		clear_nanopacket()
		clear_block_box()
		print("level cleared!")
	elif Input.is_action_just_pressed("w") and OS.is_debug_build():
		resolvelevel(available_solutions)
		print("nanopacket ran!")
	elif Input.is_action_just_pressed("e") and OS.is_debug_build():
		setlevel()
		
func resolvelevel(solutions:Dictionary):
	var output = run_nanopacket()
	
	
	if output in available_solutions:
		print("It was solution : ", available_solutions[output])
		global.add_text_to_dot_matrix(available_solutions[output].text)
	else:
		global.add_text_to_dot_matrix("You have failed in a new and interesting way!")
func setlevel():
	instruction_counter = 0
	slot_counter = 0
	if level == 1:
		create_instruction("Repeat {")
		create_instruction("Wiggle Left")
		create_instruction("Wiggle Right")
		create_instruction("}        ")
		create_instruction("}        ")
		create_instruction("}        ")
		create_instruction("}        ")
		create_instruction("}        ")
		create_instruction("}        ")
		create_instruction("{")
		create_slot()
		available_solutions={
			"EMPTY":	{
				"text": "HEY THIS IS EMPTY"
				},
			"{":
				{
				"text": "Really, you thought just a simple { was going to fix this shit?"
				}
			}


func create_instruction(blockname):
	var new_block = preload("res://Instruction.tscn").instantiate() 
	new_block.global_position = instruction_spawn_point[instruction_counter]
	new_block.set_spawnpoint(instruction_spawn_point[instruction_counter])
	instruction_counter+=1
	add_child(new_block)
	new_block.givename(blockname)
	block_box.append(new_block)
	new_block.z_index=-1
	
func create_slot():
	var new_slot = preload("res://slot.tscn").instantiate() 
	new_slot.global_position = slot_spawn_point[slot_counter]
	new_slot.givenumber(slot_counter)
	add_child(new_slot)
	nanopacket.append(new_slot)
	slot_counter += 1
	#new_slot.givename(blockname+str(instruction_counter))
