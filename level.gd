extends Node2D
var instruction_spawn_point = [Vector2(200 ,300),Vector2(200 ,370),Vector2(200 ,440)]
var instruction_counter = 0

func _ready():
	global.game_area_grid_loaded.connect(_create_blocks)


func _create_blocks(grid: GridContainer):
	print("_create_blocks", grid, global.game_area_grid)
	create_instruction("Instruction: ", grid)
	create_instruction("Instruction: ", grid)
	create_instruction("MOAR: ", grid)

func create_instruction(blockname, grid: GridContainer = null):
	var new_instruction_scene = preload("res://ControlInstruction.tscn").instantiate()
	#var new_block = preload("res://Instruction.tscn").instantiate() 
	#new_block.global_position = instruction_spawn_point[instruction_counter]

	instruction_counter+=1
	var data = {
		"blockname": blockname + str(instruction_counter),
		"number": instruction_counter
	}

	new_instruction_scene.initialize_instruction(data)

	if grid:
		grid.add_child(new_instruction_scene)
	elif global.game_area_grid:
		global.game_area_grid.add_child(new_instruction_scene)
	else:
		print("boo, no grid")
	#add_child(new_block)
	#new_block.givename(blockname+str(instruction_counter))
