extends Camera2D

@export var TargetNode : Node2D = null
var currentPosition:Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta) -> void:
	if TargetNode == null :
		set_position(currentPosition)
	else:
		var cameraPositionX: float = TargetNode.get_position().x - 275
		var cameraPositionY: float = get_position().y

		var cameraPosition: Vector2 = Vector2(cameraPositionX, cameraPositionY)
		currentPosition = cameraPosition
		set_position(cameraPosition) 
	
