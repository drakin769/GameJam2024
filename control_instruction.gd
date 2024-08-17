extends Control

@onready var instruction_node: Node2D = $Instruction


var child_data = null;

func _ready():
	print("classing _ready in control_instruction", instruction_node)
	_initialize_instruction_internal();
	update_control_size()

## This is called from the outside, on some other classe's onready, so be careful with this.
func initialize_instruction(data: Dictionary):
	print("attempting to init instruction", data)
	child_data = data;

func _initialize_instruction_internal():
	print("_initialize_instruction_internal", child_data)
	if instruction_node && child_data:
		# Assuming data contains the necessary information for the Instruction node
		instruction_node.givename(child_data["blockname"])
		instruction_node.number = child_data["number"]
		#instruction_node.unlocked = data["unlocked"]
		#instruction_node.is_held = data["is_held"]
		#instruction_node.able_to_be_held = data["able_to_be_held"]
	else: 
		print("no Instruction found :(")



func update_control_size():
	var node_size = get_node2d_size(instruction_node)
	print("Node2D size: ", node_size)
	custom_minimum_size = node_size
	size = node_size

func get_node2d_size(node: Node2D) -> Vector2:
	# Assume the Node2D has a child Sprite2D
	var sprite = node.get_child(0) if node.get_child_count() > 0 else null
	if sprite and sprite is Sprite2D:
		return sprite.texture.get_size() * sprite.scale
	else:
		return Vector2(100, 100) # Default size if no Sprite2D found
