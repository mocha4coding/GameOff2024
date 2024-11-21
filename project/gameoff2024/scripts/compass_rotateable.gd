extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var isPuzzleSolved: bool = false
var isRotatedToOriginal: bool = false
var bringBarrels: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isPuzzleSolved && !isRotatedToOriginal:
		isRotatedToOriginal = true
		animation_player.play("rotateToOriginal")


func _on_playerdetector_body_entered(body: Node2D) -> void:
	if body is Player:
		isPuzzleSolved = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "rotateToOriginal":
		bringBarrels = true
		
