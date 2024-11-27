extends LineEdit

var codeUnlocked: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#text_submitted.connect(on_line_edit_text_entered)
	text_changed.connect(on_text_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_line_edit_text_entered(new_text):
	if new_text == "759":
		codeUnlocked = true
		print("code unlocked")
	
		
func on_text_changed(new_text: String) -> void : 
	var old_caret_position: int = caret_column
	var word: String = ""
	var regex: RegEx = RegEx.new()
	regex.compile("[0-9]")
	var diff:int = regex.search_all(new_text).size() - new_text.length()
	for valid_character in regex.search_all(new_text):
		word += valid_character.get_string()
	set_text(word.to_upper())
	caret_column = old_caret_position + diff
	if word == "759":
		codeUnlocked = true
		print("code unlocked")
	
