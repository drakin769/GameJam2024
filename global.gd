extends Node
var is_dragging = false
var border = Vector2(0,0)

## Will add a new line of text to Dot matrix component.
## To add multiple lines, call this multiple times.
signal dot_matrix_add_text(new_text: String)
func add_text_to_dot_matrix(new_text: String):
	print("triger global text add")
	dot_matrix_add_text.emit(new_text)
	
## Will nuke all text from Dot matrix component.
signal dot_matrix_nuke_text()
func nuke_dot_matrix():
	print("triger global text add")
	dot_matrix_nuke_text.emit()
