extends "res://ActionButton.gd"

func _on_pressed():
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	if playerStats != null:
		if playerStats.mp >= 10:
			enemy.take_damage(8)
			playerStats.mp -= 10
			playerStats.ap -= 1
