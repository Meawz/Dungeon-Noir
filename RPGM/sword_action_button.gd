extends "res://ActionButton.gd"

var Slash = preload("res://Slash.tscn")

func _on_pressed():
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	if enemy != null and playerStats != null:
		enemy.take_damage(4)
		create_slash(enemy.position)
		playerStats.mp += 2
		playerStats.ap -= 1

func create_slash(position):
	var slash = Slash.instantiate()
	var main = get_tree().current_scene
	main.add_child(slash)
	slash.global_position = position
