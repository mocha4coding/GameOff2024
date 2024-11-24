extends Node


var currentCheckpoint: Checkpoint
var player: Player

func respawnPlayer():
	if currentCheckpoint != null:
		player.position = currentCheckpoint.global_position
		player.resetPlayer()
		
