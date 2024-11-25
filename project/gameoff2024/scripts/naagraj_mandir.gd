extends Node2D

@onready var animation_player: AnimationPlayer = $Naagraj/AnimationPlayer
var enemies: Array[Enemy] 
@onready var enemy_1: Enemy = $Enemy
@onready var enemy_2: Enemy = $Enemy2
@onready var enemy_3: Enemy = $Enemy3
@onready var enemy_4: Enemy = $Enemy4
@onready var player_detector: Area2D = $Naagraj/PlayerDetector

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
		animation_player.play("placeGemOnNaagraj")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "placeGemOnNaagraj":
		for enemy in enemies:
			enemy.isEnemyUnlocked = true
	
		player_detector.queue_free()
		