extends Node2D
var instruction_spawn_point = [Vector2(200 ,300),Vector2(200 ,370),Vector2(200 ,440)]
var instruction_counter = 0
var level = 1

func _ready():
	setlevel()
	
func setlevel():
	if level == 1:
		create_instruction("Instruction: ")
		create_instruction("Instruction: ")
		create_instruction("MOAR: ")
func create_instruction(blockname):
	var new_block = preload("res://Instruction.tscn").instantiate() 
	new_block.global_position = instruction_spawn_point[instruction_counter]
	new_block.set_spawnpoint(instruction_spawn_point[instruction_counter])
	instruction_counter+=1
	add_child(new_block)
	new_block.givename(blockname+str(instruction_counter))
