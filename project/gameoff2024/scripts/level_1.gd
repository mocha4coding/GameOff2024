extends Node2D
@onready var animatable_door: Node2D = $PopUps/GatePuzzle/AnimatableDoor
@onready var player: Player = $Player
@onready var palace_first_floor_spawn_point: Marker2D = $PalaceFirstFloorSpawnPoint
@onready var barrel_animation_player: AnimationPlayer = $Barrels/AnimationPlayer
@onready var level_1_animation_player_general: AnimationPlayer = $Level_1_animation_player_general
@onready var compass_rotateable: Node2D = $PopUps/CompassPuzzleSet/CompassRotateable
@onready var naagraj_puzzle: Node2D = $LevelDecorations/FireLavaShelter/NaagrajPuzzle
@onready var naagmani_stand: Node2D = $LevelDecorations/FireLavaShelter/NaagmaniStand
@onready var naagmani: Node2D = $LevelDecorations/FireLavaShelter/NaagmaniStand/Sprite2D/Naagmani
@onready var naagmandir_front_wall: Sprite2D = $LevelDecorations/NaagrajMandir/FrontWall
@onready var naagmandir_wheel: Node2D = $LevelDecorations/NaagrajMandir/NaagmandirWheel
@onready var start_screen: Node2D = $CanvasLayer/StartScreen
@onready var camera_2d: Camera2D = $Camera2D

var playerInGroundFloor: bool = true
var barrelVisible: bool = false
var isNaagmaniShown: bool = false
var isNaagmandirCoverDown: bool = false
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
		
	if naagraj_puzzle.isPuzzleSolved:
		if !isNaagmaniShown:
			level_1_animation_player_general.play("naagmaniStandRise")

	if naagmandir_wheel.isWheelRotated == true && isNaagmandirCoverDown == false:
		level_1_animation_player_general.play("templeCoverDown")
		camera_2d.apply_shake()
		
func _on_level_1_animation_player_general_animation_finished(anim_name: StringName) -> void:
	if anim_name == "bring_barrel":
		barrel_animation_player.play("roll")
		
	if anim_name == "naagmaniStandRise":
		isNaagmaniShown = true
		naagmani.isNaagmaniStandShown = true
	
	if anim_name == "templeCoverDown":
		isNaagmandirCoverDown = true
		naagmandir_front_wall.queue_free()


func _on_play_button_pressed() -> void:
	start_screen.queue_free()
	player.isPlayerLocked = false
