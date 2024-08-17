extends Control

@onready var instructions_grid: GridContainer = %GridContainer

func _ready():
	# Set the global reference to the GridContainer
	global.set_game_area_grid_container(instructions_grid)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
