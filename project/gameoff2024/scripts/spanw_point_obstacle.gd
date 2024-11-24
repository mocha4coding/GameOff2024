extends RigidBody2D


var player: Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player!= null:
		if Input.is_action_pressed("interact"):
			print("E is pressed")
			var force = player.playerHorizontalDirectionVector.normalized() * 40
			player.speed = (player.speed)/3
			player.playerMotionMode = player.playerMotionStates.pushPull
			print("Force applied ", force )
			apply_central_impulse(force)
		if Input.is_action_just_released("interact"):
			print("E is released")
			player.playerMotionMode = player.playerMotionStates.idle
			player.speed = player.MAX_SPEED
			
func playerEnteredPlayerDetector(body: Node2D) -> void:
	if body is Player:
		player = body
		print("Box has detected player")
		
func handlePlayerLeaving(body:Node2D) -> void:
	if body is Player: 
		if player != null:
			player.speed = player.MAX_SPEED
			player.playerMotionMode = player.playerMotionStates.idle
			player = null
			print("Player has left the box")


func _on_player_detector_body_entered(body: Node2D) -> void:
	playerEnteredPlayerDetector(body)


func _on_player_detector_body_exited(body: Node2D) -> void:
	handlePlayerLeaving(body)
