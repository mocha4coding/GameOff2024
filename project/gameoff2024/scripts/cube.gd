extends CharacterBody2D

var player: Player = null
var cubeDirection: int = 0
var isCubeAttached: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		
	if player!= null:
		if Input.is_action_just_pressed("interact") and is_on_floor():
			isCubeAttached = !isCubeAttached
		#if is_on_floor():
			#if Input.is_action_pressed("interact"):
				#isCubeAttached = true
			#elif Input.is_action_just_released("interact"):
				#isCubeAttached = false
	#print("Is Cube attached ", isCubeAttached)
	handleCubeHorizontalMotion()
	move_and_slide()
		
	
			
func handleCubeHorizontalMotion() -> void:
	if player != null:
		cubeDirection = player.playerDirection
	else:
		cubeDirection = 0
	
	#print("Is Cube attached ", isCubeAttached)
	if isCubeAttached:
		velocity.x = cubeDirection * player.SPEED
	else:
		velocity.x = 0
	#print(velocity.x)
	
		
func _on_player_detector_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		#print("Cube detected plaer")

func _on_player_detector_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null
		#print("Player left cube")
		cubeDirection = 0
		isCubeAttached = false
