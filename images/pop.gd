extends AnimatedSprite2D
var ending = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global.game_over == true and ending == false:
		play("pop")
		ending=true
	pass
