extends Node2D

@onready var play_again_button: Button = $PlayAgainButtonicon/PlayAgainButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_again_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_play_again_button_mouse_entered() -> void:
	play_again_button.scale = Vector2(1.1, 1.1)


func _on_play_again_button_mouse_exited() -> void:
	play_again_button.scale = Vector2(1.0, 1.0)
