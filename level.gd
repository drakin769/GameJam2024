extends Node2D
var instruction_spawn_point = [Vector2(95 ,350),Vector2(100 ,420),Vector2(100,490), Vector2(100 ,560)]
var slot_spawn_point = [Vector2(500 ,350),Vector2(820 ,350),Vector2(500 ,420),Vector2(820 ,420)]
var instruction_counter = 0
var slot_counter = 0
var level = 1

func _ready():
	setlevel()
	
func setlevel():
	if level == 1:
		create_instruction("Repeat {")
		create_instruction("Wiggle Left")
		create_instruction("Wiggle Right")
		create_instruction("}        ")
		create_slot()
		create_slot()
		create_slot()
		create_slot()	
func create_instruction(blockname):
	var new_block = preload("res://Instruction.tscn").instantiate() 
	new_block.global_position = instruction_spawn_point[instruction_counter]
	new_block.set_spawnpoint(instruction_spawn_point[instruction_counter])
	instruction_counter+=1
	add_child(new_block)
	new_block.givename(blockname)
	
func create_slot():
	var new_slot = preload("res://slot.tscn").instantiate() 
	new_slot.global_position = slot_spawn_point[slot_counter]
	new_slot.givenumber(slot_counter)
	add_child(new_slot)
	slot_counter += 1
	#new_slot.givename(blockname+str(instruction_counter))
