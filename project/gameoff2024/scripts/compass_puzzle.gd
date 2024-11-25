extends Node2D

@onready var n_button: TextureButton = $Puzzle/NButton
@onready var s_button: TextureButton = $Puzzle/SButton
@onready var e_button: TextureButton = $Puzzle/EButton
@onready var w_button: TextureButton = $Puzzle/WButton

var puzzleSolved: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_n_button_pressed() -> void:
	pass
	
	


func _on_s_button_pressed() -> void:
	puzzleSolved = true
	
