extends Node2D
class_name PlayerHealthBar
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func decreaseHealthBarValue(damage: int) -> void:
	texture_progress_bar.value-= damage
	
func increaseHealthBarValue(health: int) -> void:
	texture_progress_bar.value+= health

func setHealthBarValue(health: int) -> void:
	texture_progress_bar.value = health
