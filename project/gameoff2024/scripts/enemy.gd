extends CharacterBody2D

class_name Enemy
var timeTakenToMove : int = 100
var playerChase : bool = false
var player : Player = null
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var isAnimatedSpriteFliiped : bool = false
var attackModeOn: bool = false
var enemyHealth:float = 30
var spawnPosition: Vector2 = global_position
var gotHit: bool = false
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
	if isEnemyUnlocked:
		if attackModeOn:
			attackOnPlayer()
		else:
			if playerChase:
				handlePlayerChase()
			else:
				handleIdleState()
				#print("Bee positon after player detected " , position )
		if player != null:
			if player.position.x - position.x > 0 :
				animated_sprite_2d.flip_h = false
			elif player.position.x - position.x < 0:
				animated_sprite_2d.flip_h = true
	else:
		if enemyHealth >0:
			animated_sprite_2d.play("idleFrozen")
		else:
			animated_sprite_2d.play("death")
	
func handleIdleState():
	animated_sprite_2d.play("idleMotion")
	enemyMotionMode = enemyMotionStates.idleMotion
	
func getHit(damageAmount: float):
	if enemyHealth > 0:
		enemyHealth -= damageAmount
		gotHit = true
	else:
		isEnemyUnlocked = false

func attackOnPlayer():
	animated_sprite_2d.play("attack")
	enemyMotionMode = enemyMotionStates.attack
	if player.currentHealth > 0:
		player.reduceHealth(0.05)
	else:
		attackModeOn = false
	
	

func handlePlayerChase():
	position.x += (player.position.x - position.x)/timeTakenToMove
	animated_sprite_2d.play("walk")
		
func handlePlayerEnteredPlayerPositionDetector(body):
	if body is Player:
		#print("Player detected")
		player = body
		playerChase = true


func handlePlayerExitPlayerPositionDetector(body):
	if body is Player:
		player = null
		playerChase = false



func handlePlayerEnteringHitArea(body):
	if body is Player:
		player = body
		attackModeOn = true
		print("Attack mode is set to on")
		


func handlePlayerExitingHitArea(body):
	if body is Player:
		player = body
		attackModeOn = false
		print("Attack mode is set to off")

func _on_animated_sprite_2d_animation_finished():
	if enemyMotionMode == enemyMotionStates.attack:
		print("attacking finished")
	if gotHit:
		gotHit = false
	if enemyHealth <= 0:
		queue_free()


func _on_player_position_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		handlePlayerEnteredPlayerPositionDetector(body)


func _on_player_position_detector_body_exited(body: Node2D) -> void:
	if body is Player:
		handlePlayerExitPlayerPositionDetector(body)


func _on_hit_area_body_entered(body: Node2D) -> void:
	if body is Player:
		handlePlayerEnteringHitArea(body)


func _on_hit_area_body_exited(body: Node2D) -> void:
	if body is Player:
		handlePlayerExitingHitArea(body)
