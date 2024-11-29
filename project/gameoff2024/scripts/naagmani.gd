extends Node2D

var isNaagmaniStandShown: bool = false
var player: Player = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isNaagmaniStandShown && player != null:
		player.collectibles.append(self)
		print("Collectibles of player", player.collectibles)
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		
