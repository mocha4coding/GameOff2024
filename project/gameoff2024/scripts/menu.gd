extends Node2D
@onready var menu_icon: Sprite2D = $MenuIcon

@onready var menu_details: Sprite2D = $MenuDetails
var isButtonEnabled: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_details.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_menu_button_pressed() -> void:
	if isButtonEnabled:
		menu_details.hide()
	else:
		menu_details.show()
	
	isButtonEnabled = !isButtonEnabled

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_menu_button_mouse_entered() -> void:
	menu_icon.scale = Vector2(1.1, 1.1)


func _on_menu_button_mouse_exited() -> void:
	menu_icon.scale = Vector2(1, 1)
