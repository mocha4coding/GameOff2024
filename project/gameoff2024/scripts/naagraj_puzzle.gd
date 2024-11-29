extends Node2D

@onready var _00: Sprite2D = $"00" #90
@onready var _01: Sprite2D = $"01" #180
@onready var _10: Sprite2D = $"10" #270
@onready var _11: Sprite2D = $"11" #270


@onready var _00_button: Button = $"00/00_button"
@onready var _01_button: Button = $"01/01_button"
@onready var _10_button: Button = $"10/10_button"
@onready var _11_button: Button = $"11/11_button"

var _00_clicksLeft : int = 1
var _01_clicksLeft : int = 2
var _10_clicksLeft : int = 3
var _11_clicksLeft : int = 3

var isPuzzleSolved: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var totalClicksLeft: int = _00_clicksLeft + _01_clicksLeft + _10_clicksLeft + _11_clicksLeft
	if totalClicksLeft == 0:
		isPuzzleSolved = true
		print("Naagraj puzzle solved")



func _on_zero_zero_button_pressed() -> void:
	print(_00_clicksLeft, " 00 before rotation")
	if _00_clicksLeft:
		_00.rotate((PI/2))
		_00_clicksLeft-= 1
	print(_00_clicksLeft, " 00 after rotation")


func _on_zero_one_button_pressed() -> void:
	
	print( _01_clicksLeft, " 01 before rotation")
	if _01_clicksLeft:
		_01.rotate(PI/2)
		_01_clicksLeft -= 1
	print( _01_clicksLeft, " 01 after rotation")


func _on_one_zero_button_pressed() -> void:
	print(_10_clicksLeft, " 10 before rotation")
	if _10_clicksLeft:
		_10.rotate(PI/2)
		_10_clicksLeft -= 1
	print(_10_clicksLeft, " 10 after rotation")


func _on_one_one_button_pressed() -> void:
	print(_11_clicksLeft, " 11 before rotation")
	if _11_clicksLeft:
		_11.rotate(PI/2)
		_11_clicksLeft -= 1
	print(_11_clicksLeft, " 11 after rotation")
