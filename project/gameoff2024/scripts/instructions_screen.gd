extends Node2D

@onready var instructions_screen: Node2D = $"."
@onready var close_button: Button = $CloseButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instructions_screen.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_button_pressed() -> void:
	instructions_screen.hide()
