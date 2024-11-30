extends CharacterBody2D

class_name Player
const MAX_SPEED = 450.0
var speed = MAX_SPEED
const JUMP_VELOCITY = -600.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const MAX_HEALTH = 100
var logtag :String = "PlayerScript"
@export var healthBar: Node2D = null
@onready var sword_attack_area_right_spawn_point: Marker2D = $SwordAttackAreaRightSpawnPoint
@onready var sword_attack_area_left_spawn_point: Marker2D = $SwordAttackAreaLeftSpawnPoint
@onready var sword_attack_area: Area2D = $SwordAttackArea

var collectibles: Array = []
enum playerMotionStates {
	idle,
	walk,
	jump,
	attack,
	pushPull,
	deathFight,
	deathAccident
}
var currentHealth: float = MAX_HEALTH 
var playerMotionMode: int = playerMotionStates.idle 
var playerDirection: int = 0
var playerHorizontalDirectionVector: Vector2 = Vector2.ZERO
var enemies: Array[Enemy] = []

func _physics_process(delta: float) -> void:
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var input_direction =  Vector2(Input.get_axis("left", "right"), 0).normalized()
	playerHorizontalDirectionVector = input_direction
	if currentHealth > 0 :
		handleVerticalMotion()
		handleHorizontalMotion()
		handleAttack()
	handlePlayerAnimationSprite()
	syncPlayerHealthWithHealthBar()

	move_and_slide()

func performAttack():
	for enemy in enemies:
		if enemy.enemyHealth >= 0:
			print("Hitting enemy")
			enemy.getHit(10)
		else:
			enemies.erase(enemy)
			
func handleAttack():
	if Input.is_action_pressed("attack"):
		playerMotionMode = playerMotionStates.attack
		
	
func handleVerticalMotion() -> void:
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if isPlayerInAir() == true:
		playerMotionMode = playerMotionStates.jump
	else:
		if playerMotionMode != playerMotionStates.pushPull:
			playerMotionMode = playerMotionStates.idle 
		
func handleHorizontalMotion() -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	playerDirection = Input.get_axis("left", "right")
	if playerDirection:

		velocity.x = playerDirection * speed
		
		if playerMotionMode != playerMotionStates.jump && playerMotionMode != playerMotionStates.pushPull:
			playerMotionMode = playerMotionStates.walk
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if !otherAnimationPlayingWhileIdle():
			playerMotionMode = playerMotionStates.idle

func otherAnimationPlayingWhileIdle() -> bool: 
	 
	if playerMotionMode == playerMotionStates.jump: 
		return true
	 
	if playerMotionMode == playerMotionStates.pushPull:
		return true
	
	if playerMotionMode == playerMotionStates.deathAccident: 
		return true
	
	if playerMotionMode == playerMotionStates.attack:
		return true
		
	return false
	
func handlePlayerAnimationSprite() -> void:
	if playerMotionMode ==  playerMotionStates.idle:
		animated_sprite_2d.play("idle")
	elif playerMotionMode == playerMotionStates.walk:
		animated_sprite_2d.play("walk")
	elif playerMotionMode == playerMotionStates.jump:
		animated_sprite_2d.play("jump")
	elif playerMotionMode == playerMotionStates.attack:
		animated_sprite_2d.play("attack")
	elif playerMotionMode == playerMotionStates.pushPull:
		animated_sprite_2d.play("push")
	elif playerMotionMode == playerMotionStates.deathAccident:
		
			animated_sprite_2d.play("deathAccident")
			
	
	else:
		animated_sprite_2d.play("idle")
	
	if playerMotionMode != playerMotionStates.pushPull:
		if playerDirection < 0 :
			animated_sprite_2d.flip_h = true
			sword_attack_area.global_position = sword_attack_area_left_spawn_point.global_position
		elif playerDirection > 0:
			animated_sprite_2d.flip_h = false
			sword_attack_area.global_position = sword_attack_area_right_spawn_point.global_position

func isPlayerInAir() -> bool:
	if is_on_floor():
		return false
	return true

func syncPlayerHealthWithHealthBar():
	if healthBar != null && healthBar is PlayerHealthBar:
		healthBar.setHealthBarValue(currentHealth)
	else:
		if healthBar == null :
			print(logtag, "Health bar is null")
		if !(healthBar is PlayerHealthBar):
			print(logtag, "Health bar node is not of type PlayerHealthBar")
		
func reduceHealth(damage: float) -> void:
	currentHealth -= damage
	if currentHealth <= 0:
		playerMotionMode = playerMotionStates.deathAccident
		
		
	
	
func fade_out():
	var tween = get_tree().create_tween()
	tween.tween_property(animated_sprite_2d, "modulate:a", 0.0, 3.0)
	
func fade_in():
	var tween = get_tree().create_tween()
	tween.tween_property(animated_sprite_2d, "modulate:a", 1.0, 3.0)


func _on_sword_attack_area_body_entered(body: Node2D) -> void:
	if body is Enemy:
		if body.enemyHealth > 0:
			enemies.append(body)
			print("Enemy added")


func _on_sword_attack_area_body_exited(body: Node2D) -> void:
	if body is Enemy:
		enemies.erase(body)


func _on_animated_sprite_2d_animation_finished() -> void:
	performPostAnimationActions(animated_sprite_2d.animation)

func performPostAnimationActions(anim_name: String):
	if anim_name == "attack":
		performAttack()
	elif anim_name == "deathAccident":
		GameManager.respawnPlayer()
func resetPlayer():
	playerMotionMode = playerMotionStates.idle
	currentHealth = MAX_HEALTH


func _on_animated_sprite_2d_animation_looped() -> void:
	performPostAnimationActions(animated_sprite_2d.animation)
