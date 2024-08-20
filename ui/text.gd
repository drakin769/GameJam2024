extends RichTextLabel
var paperclips =""
var local_paperclips =-50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		if local_paperclips<global.paperclips*10:
			print(global.paperclips)
			print_paperclips()
		elif global.paperclips==0:
			text=""
func print_paperclips():
	text+="📎"
	local_paperclips+=1
