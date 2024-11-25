extends Node2D
@onready var animatable_door: Node2D = $PopUps/GatePuzzle/AnimatableDoor
@onready var player: Player = $Player
@onready var palace_first_floor_spawn_point: Marker2D = $PalaceFirstFloorSpawnPoint
@onready var barrel_animation_player: AnimationPlayer = $Barrels/AnimationPlayer
@onready var level_1_animation_player_general: AnimationPlayer = $Level_1_animation_player_general
@onready var compass_rotateable: Node2D = $PopUps/CompassPuzzleSet/CompassRotateable

var playerInGroundFloor: bool = true
var barrelVisible: bool = false
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
	
	if compass_rotateable.bringBarrels == true && barrelVisible == false:
		barrelVisible = true
		level_1_animation_player_general.play("bring_barrel")


func _on_level_1_animation_player_general_animation_finished(anim_name: StringName) -> void:
	if anim_name == "bring_barrel":
		barrel_animation_player.play("roll")
