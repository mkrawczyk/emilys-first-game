extends Node

@export var mob_scene: PackedScene
var score

func _ready() -> void:
	new_game()

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	
func new_game() -> void:
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Lizgard scene
	var mob = mob_scene.instantiate()
	
	# Choose a random location along the spawn path
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# Set the direction perpendicular to the path direction
	var direction = mob_spawn_location.rotation + PI/2
	
	# Set the position to a random location
	mob.position = mob_spawn_location.position
	
	# Add some randomness to the direction
	direction += randf_range(-PI/4, PI/4)
	mob.rotation += direction
	
	# Choose the velocity for the creature
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# And now spawn the thing
	add_child(mob)


func _on_score_timer_timeout() -> void:
	score += 1


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
