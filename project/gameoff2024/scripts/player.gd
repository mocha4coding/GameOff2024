extends CharacterBody2D

class_name Player
const SPEED = 450.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const MAX_HEALTH = 100

@export var healthBar: Node2D = null
enum playerMotionStates {
	idle,
	walk,
	jump,
	attack
}

var currentHealth: float = MAX_HEALTH - 20
var playerMotionMode: int = playerMotionStates.idle 
var playerDirection: int = 0

func _physics_process(delta: float) -> void:
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	handleVerticalMotion()
	handleHorizontalMotion()
	handlePlayerAnimationSprite()
	syncPlayerHealthWithHealthBar()

	move_and_slide()
	
func handleVerticalMotion() -> void:
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if isPlayerInAir() == true:
		playerMotionMode = playerMotionStates.jump
	else:
		playerMotionMode = playerMotionStates.idle 
		
func handleHorizontalMotion() -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	playerDirection = Input.get_axis("left", "right")
	if playerDirection:
		velocity.x = playerDirection * SPEED
		if playerMotionMode != playerMotionStates.jump:
			playerMotionMode = playerMotionStates.walk
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if playerMotionMode != playerMotionStates.jump:
			playerMotionMode = playerMotionStates.idle

func handlePlayerAnimationSprite() -> void:
	if playerMotionMode ==  playerMotionStates.idle:
		animated_sprite_2d.play("idle")
	elif playerMotionMode == playerMotionStates.walk:
		animated_sprite_2d.play("walk")
	elif playerMotionMode == playerMotionStates.jump:
		animated_sprite_2d.play("jump")
	elif playerMotionMode == playerMotionStates.attack:
		animated_sprite_2d.play("attack")
	else:
		animated_sprite_2d.play("idle")
		
	if playerDirection < 0 :
		animated_sprite_2d.flip_h = true
	elif playerDirection > 0:
		animated_sprite_2d.flip_h = false

func isPlayerInAir() -> bool:
	if is_on_floor():
		return false
	return true

func syncPlayerHealthWithHealthBar():
	if healthBar != null && healthBar is PlayerHealthBar:
		healthBar.setHealthBarValue(currentHealth)
		
func reduceHealth(damage: float) -> void:
	currentHealth -= damage
	
