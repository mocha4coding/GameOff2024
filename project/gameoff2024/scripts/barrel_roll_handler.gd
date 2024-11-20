extends Node2D

@onready var barrel: StaticBody2D = $Barrel
@onready var barrel_2: StaticBody2D = $Barrel2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_chande_direction_body_entered(body: Node2D) -> void:
	if body.has_method("has_variable") and body.has_variable("initialDirection"):
		body.initialDirection = body.initialDirection * -1


func _on_chande_direction_2_body_entered(body: Node2D) -> void:
	if body.has_method("has_variable") and body.has_variable("initialDirection"):
		body.initialDirection = body.initialDirection * -1
