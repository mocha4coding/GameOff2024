extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gate_moveable: Sprite2D = $GateMoveable


var isKeyPresent: bool = false
var isGateOpen: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isKeyPresent:
		if !isGateOpen:
			animation_player.play("liftGate")
			isGateOpen = true


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		isKeyPresent = true
