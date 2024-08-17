extends Node
var is_dragging = false

var game_area_grid: GridContainer = null

signal game_area_grid_loaded(grid: GridContainer)

func set_game_area_grid_container(container: GridContainer):
	print("set and emit() grid", container)
	game_area_grid = container
	game_area_grid_loaded.emit(container)
