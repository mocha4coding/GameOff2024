extends Node2D

@onready var animation_player: AnimationPlayer = $Naagraj/AnimationPlayer
var enemies: Array[Enemy] 
@onready var enemy_1: Enemy = $Enemy
@onready var enemy_2: Enemy = $Enemy2
@onready var enemy_3: Enemy = $Enemy3
@onready var enemy_4: Enemy = $Enemy4
@onready var naagraj_player_detector: Area2D = $Naagraj/PlayerDetector
@onready var front_wall: Sprite2D = $FrontWall
@onready var naagmandir_wheel: Node2D = $NaagmandirWheel
var player: Player = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemies.append(enemy_1)
	enemies.append(enemy_2)
	enemies.append(enemy_3)
	enemies.append(enemy_4)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		#hardcoding will change later
		if body.collectibles.size() != 0 :
			animation_player.play("placeGemOnNaagraj")
			


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "placeGemOnNaagraj":
	
		for enemy in enemies:
			enemy.isEnemyUnlocked = true
		animation_player.play("attackInstructionScrollDown")
		naagraj_player_detector.queue_free()
		
