extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var initialDirection: int = -1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if initialDirection == -1:
		animation_player.play("roll")
	else:
		animation_player.play_backwards("roll")
		
	
