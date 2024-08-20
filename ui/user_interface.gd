extends ColorRect
var  rollcredits= false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.add_text_to_dot_matrix("Well. Seems like it's online. Now to test NanoBot #42 out... Does it work? Power on, #42!")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global.game_over==true and rollcredits==false:
		await get_tree().create_timer(15).timeout
		$Credits.visible=true
