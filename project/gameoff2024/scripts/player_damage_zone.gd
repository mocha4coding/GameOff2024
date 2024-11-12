extends Area2D

@export var damage: float = 0.1
var startDamagingPlayer: bool = false
var player: Player = null
var logtag: String = "PlayerDamageZone Area2D"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player != null:
		if startDamagingPlayer:
			player.reduceHealth(damage)
		


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		startDamagingPlayer = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null
		startDamagingPlayer = false
