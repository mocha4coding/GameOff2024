extends LineEdit

var codeUnlocked: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_submitted.connect(on_line_edit_text_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_line_edit_text_entered(new_text):
	if new_text == "759":
		codeUnlocked = true
		print("code unlocked")
	
		
