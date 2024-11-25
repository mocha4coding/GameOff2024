extends Node2D

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
var isBoardShown: bool = false
var isPlayerInsideDetectionArea: bool = false
var isScrollMoveUpAnimationTriggered: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isBoardShown:
		if Input.is_action_pressed("interact") && !isScrollMoveUpAnimationTriggered:
			print("Push pull : First E pressed")
			animation_player.play("PushPullScrollsBackward")
			isScrollMoveUpAnimationTriggered = true


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		animation_player.play("PushPullScrolls")
		isPlayerInsideDetectionArea = true
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "PushPullScrollsBackward" && isScrollMoveUpAnimationTriggered:
		self.queue_free()
	if anim_name == "PushPullScrolls":
		isBoardShown = true


func _on_player_detector_body_exited(body: Node2D) -> void:
	isPlayerInsideDetectionArea = false
