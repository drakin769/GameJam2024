extends RichTextLabel

@onready var paper_text: RichTextLabel = %PaperText

var text_queue: Array = []
var length_letters = 0
var lock_write = false
var seconds_between_text_lines = 1
var TextEndtimer = SceneTreeTimer
var cancel_writing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.connect("dot_matrix_add_text", _on_add_text_from_signal)
	global.connect("dot_matrix_nuke_text", _on_nuke_all_text)

func _on_add_text_from_signal(text: String):
	_add_text_to_queue(text)
	#display_written_text(text)
	pass

func _display_written_text(text, animate: bool = false, typing_speed=0.03):
	if cancel_writing:
		lock_write = false
		return

	if lock_write:
		push_error(
			'Oops, looks like you were trying to write text to '
			+ 'Dot Matrix, while the Dot matrix is already writing 😵‍💫'
		)
		return

	lock_write = true
	
	#add prefix :p
	paper_text.add_text("> ")
	var length = paper_text.get_parsed_text().length();
	
	# We first set visible characters to the existing text,
	# in order to reveal the added text character-by-character
	visible_characters = length

	# built-in function that adds text to the label.
	add_text(text)
	
	if animate:
		# get the characters of the text that will be animated for our loop
		# and the new length; ie. (min, max)
		var newLength = paper_text.get_parsed_text().length()

		for letter in range(length, newLength):
			if cancel_writing:
				lock_write = false
				return
			
			await get_tree().create_timer(typing_speed).timeout
			
			paper_text.visible_characters = letter+1
	
	# adding new line to ensure next text will be on a new line.
	newline()
	
	# ensure newline characters are "visible" otherwise future math will be wrong!
	var finalLength = paper_text.get_parsed_text().length()
	visible_characters = finalLength
	
	# wait the given time, before we allow more text to be "written"
	await get_tree().create_timer(seconds_between_text_lines).timeout
	lock_write = false

func _consume_from_text_queue():
	if lock_write != true && !cancel_writing:
		var text_object = text_queue.pop_back()
		_display_written_text(text_object.text, true, text_object.typing_speed)

func _add_text_to_queue(string: String, typing_speed: float = 0.03):
	# any new assignment to text, should cancel the cancel 👀
	cancel_writing = false
	if text_queue == null:
		push_error("uh oh, text_queue isn't an array for some reason!")

	text_queue.push_front(
		{
			"text": string, 
			"typing_speed": typing_speed
		}
	)

func _on_nuke_all_text():
	cancel_writing = true
	paper_text.text = ""
	text_queue.clear()
	lock_write = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !text_queue.is_empty():
		_consume_from_text_queue()
	pass


class TextQueue:
	var text_entries: Array[DotMatrixText] = []
	
class DotMatrixText:
	var yolo = "yolo"
	
