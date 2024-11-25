extends CharacterBody2D

class_name Enemy
var timeTakenToMove : int = 100

var player : Player = null
@onready var hit_box: Area2D = $HitBox

@onready var animated_sprite_2d = $AnimatedSprite2D
@export var isAnimatedSpriteFliiped : bool = false
@onready var hit_box_left_position: Marker2D = $HitBoxLeftPosition
@onready var hit_box_right_position: Marker2D = $HitBoxRightPosition
var enemyDirection: Vector2 
var enemyHealth:float = 30
var spawnPosition: Vector2 = global_position
var chasePlayer: bool = false
var enableMelee: bool = false
var playerInHitBox: bool = false
var enemyMotionMode: enemyMotionStates = enemyMotionStates.idleMotion
var isEnemyUnlocked: bool = true
enum enemyMotionStates {
	idleFrozen,
	idleMotion,
	walk,
	attack,
	death
}
func _ready():
	animated_sprite_2d.play("idleFrozen")
	if isAnimatedSpriteFliiped:
		animated_sprite_2d.flip_h = true
	
	
func _physics_process(delta):
		
		if animated_sprite_2d.flip_h == true:
			hit_box.position = hit_box_left_position.position
		else:
			hit_box.position = hit_box_right_position.position
			
		if player != null:
			enemyDirection = (player.global_position- global_position).normalized()
			if chasePlayer:
				if enemyDirection.x > 0 :
					animated_sprite_2d.flip_h = false
				elif enemyDirection.x < 0:
					animated_sprite_2d.flip_h = true
				
				if enableMelee:
					performMeleeAttack()
					# if playerInHitBox then when animation finished reduce player health
						
				else:
					
					
					handlePlayerChase(delta)
		else:
			#if armor is unlocked then
				#if armor is alive  
					#if position is not same as spawn position walk to spawn position
				#else 
					#if dead animation not played
						#player dead animation
			#else
				#idleFreezeMotion	
			handleIdleState()
	
func performMeleeAttack():
	enemyMotionMode = enemyMotionStates.attack
	animated_sprite_2d.play("attack")
	

func handleIdleState():
	animated_sprite_2d.play("idleMotion")
	#enemyMotionMode = enemyMotionStates.idleMotion
	
func getHit(damageAmount: float):
	if enemyHealth > 0:
		enemyHealth -= damageAmount
	else:
		isEnemyUnlocked = false


	
	

func handlePlayerChase(delta):
	#position.x += (player.position.x - position.x)/timeTakenToMove
	 # Calculate the direction to the player
	
	global_position.x += enemyDirection.x * timeTakenToMove * delta
	animated_sprite_2d.play("walk")





func _on_player_chase_area_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		chasePlayer = true
		player = body


func _on_player_chase_area_detector_body_exited(body: Node2D) -> void:
	if body is Player:
		chasePlayer = false
		player = null
		
	


func _on_melee_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		enableMelee = true

func _on_melee_zone_body_exited(body: Node2D) -> void:
	if body is Player:
		enableMelee = false


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Player:
		playerInHitBox = true


func _on_hit_box_body_exited(body: Node2D) -> void:
	if body is Player:
		playerInHitBox = false


func _on_animated_sprite_2d_animation_looped() -> void:
	handleAnimationLoopOrFinishActions(animated_sprite_2d.animation)
		
func _on_animated_sprite_2d_animation_finished():
	handleAnimationLoopOrFinishActions(animated_sprite_2d.animation)


func handleAnimationLoopOrFinishActions(anim_name: String):
	if anim_name == "attack" && playerInHitBox:
		player.reduceHealth(10)
	
