extends Node2D
class_name Checkpoint
@export var isSpawnPoint: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate(body: Player):
	GameManager.currentCheckpoint = self
	GameManager.player = body
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		activate(body)
