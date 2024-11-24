extends Node2D

@onready var animatable_door: Node2D = $AnimatableDoor
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
var isGatePuzzleShown : bool = false
@onready var line_edit: LineEdit = $Sprite2D/LineEdit
@onready var popup_sprite: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if animatable_door.isPlayerInFrontOfGate == true && isGatePuzzleShown!= true:
		animation_player.play("gatePuzzleScrollsDown")
	
	if popup_sprite!= null && line_edit.codeUnlocked == true:
		animatable_door.isKeyPresent = true
		animation_player.play("gatePuzzleScrollsUp")
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "gatePuzzleScrollsDown":
		isGatePuzzleShown = true
	if anim_name == "gatePuzzleScrollsUp":
		animatable_door.isKeyPresent = true
		popup_sprite.queue_free()
