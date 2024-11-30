extends Node2D

@onready var naagmandir_wheel_player: AnimationPlayer = $naagmandirWheelPlayer
var isWheelRotated: bool = false
var player: Player = null
@onready var player_detector: Area2D = $PlayerDetector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !isWheelRotated && player != null &&  Input.is_action_just_pressed("interact"):
		naagmandir_wheel_player.play("rotateWheel")


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body


func _on_player_detector_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null


func _on_naagmandir_wheel_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "rotateWheel":
		isWheelRotated = true
		player_detector.queue_free()
