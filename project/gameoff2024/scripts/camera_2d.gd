extends Camera2D

@export var TargetNode: Node2D = null
@export var right_drag_threshold: float = 100.0 # Threshold for right movement
@export var horizontal_offset: float = 160.0 # Horizontal offset for the camera
@export var smoothness: float = 5.0 # Higher values make movement smoother

@export var randomShakeStrenght: float = 20.0
@export var shakeFade: float = 5.0

var randomNumberGenerator = RandomNumberGenerator.new()
var overallShakeStrength : float = 0.0

var left_offset : float = 1080 - 160
var right_offset : float = 160
var current_position: Vector2 = Vector2.ZERO

func _ready():
	if TargetNode == null:
		print("Camera2D target node is null")
	else:
		# Initialize the camera's position to match the target initially with offset
		current_position = Vector2(TargetNode.position.x - horizontal_offset, position.y)
		set_position(current_position)

func _process(delta: float) -> void:
	
	if overallShakeStrength > 0:
		overallShakeStrength = lerpf(overallShakeStrength, 0, shakeFade * delta)
		offset = random_offset()
		
	
	if TargetNode == null:
		set_position(current_position)
		return
	
	if TargetNode.playerDirection == -1 :
		horizontal_offset = left_offset
	elif TargetNode.playerDirection == 1  :
		horizontal_offset = right_offset
	# Target position with horizontal offset
	var target_x: float = TargetNode.position.x - horizontal_offset

	# Check horizontal movement direction
	var moving_left: bool = target_x < current_position.x
	
	if moving_left:
		# No drag when moving left; follow immediately
		current_position.x = target_x
		
	else:
		
		# Drag effect for right movement
		var distance_x: float = abs(target_x - current_position.x)
		if distance_x > right_drag_threshold:
			# Move towards the target position beyond the drag threshold
			var direction: float = sign(target_x - current_position.x)
			current_position.x += direction * (distance_x - right_drag_threshold)

	# Smoothly interpolate to the new position
	var smoothed_position = Vector2(
		lerp(position.x, current_position.x, smoothness * delta),
		position.y
	)
	set_position(smoothed_position)

func apply_shake():
	overallShakeStrength = randomShakeStrenght

func random_offset():
	return Vector2(randomNumberGenerator.randf_range(-overallShakeStrength, overallShakeStrength),randomNumberGenerator.randf_range(-overallShakeStrength, overallShakeStrength))
	
