extends Button

var BattleUnits = preload("res://BattleUnits.tres")

func _on_pressed():
	var enemy = BattleUnits.Enemy
	var playerStats = BattleUnits.PlayerStats
	if enemy != null and playerStats != null:
		enemy.take_damage(8)
		playerStats.mp -= 10
		playerStats.ap -= 1
