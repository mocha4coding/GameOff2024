extends Node2D

@onready var animatable_door: Node2D = $LevelDecorations/SpawnPointPalaceGroundFloorWall/AnimatableDoor
@onready var player: Player = $Player
@onready var palace_first_floor_spawn_point: Marker2D = $PalaceFirstFloorSpawnPoint

var playerInGroundFloor: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if animatable_door.isGateOpen && playerInGroundFloor:
		player.fade_out()
		player.global_position = Vector2(player.global_position.x, palace_first_floor_spawn_point.global_position.y)
		player.fade_in()
		playerInGroundFloor = false
