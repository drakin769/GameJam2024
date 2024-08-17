extends RichTextLabel

@onready var paper_text: RichTextLabel = %PaperText
var length_letters = 0 
var lock_write = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display_written_text("hi there", true)
	await get_tree().create_timer(2).timeout
	display_written_text("How are you feeling?", true, 0.05)
	await get_tree().create_timer(3).timeout
	display_written_text("What's your name?", true)
	await get_tree().create_timer(5).timeout
	display_written_text("???", true)
	await get_tree().create_timer(4).timeout
	display_written_text("WELLL????", true, 0.03)
	await get_tree().create_timer(1).timeout
	display_written_text("😡😡😡🤬🤬🤬", true, 0.01)
	await get_tree().create_timer(4).timeout
	display_written_text("🤡", true, 0.01)
	#paper_text.visible_characters = 0
	#paper_text.text = "yollo"
#
	#var typing_speed = 0.1
	#var letters: int = paper_text.text.length()
#
	#print("letters",letters)
	#for letter in letters:
		#await get_tree().create_timer(typing_speed).timeout
		#print(letter)
		#paper_text.visible_characters = letter+1
	pass # Replace with function body.

func display_written_text(text, animate: bool = false, typing_speed=0.1):
	if lock_write:
		print('oops')
		return
	lock_write = true
	var length = paper_text.get_parsed_text().length();
	
	visible_characters = length
	add_text(text)
	
	length_letters = paper_text.text.length()
	var newLength = paper_text.get_parsed_text().length()

	if animate:
		for letter in range(length, newLength):
			await get_tree().create_timer(typing_speed).timeout
			paper_text.visible_characters = letter+1

	newline()
	var finalLength = paper_text.get_parsed_text().length()
	visible_characters = finalLength
	lock_write = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
