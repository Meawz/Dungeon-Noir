extends Node

var BattleUnits = preload("res://BattleUnits.tres")

@export var enemies:Array[PackedScene]

@onready var battleActionButtons = $UI/BattleActionButtons
@onready var animationPlayer = $AnimationPlayer
@onready var nextRoomButton = $UI/CenterContainer/NextRoomButton
@onready var enemyPosition = $EnemyPosition

func _ready():
	randomize()
	start_player_turn()
	var enemy = BattleUnits.Enemy
	if enemy != null:
		enemy.died.connect(_on_enemy_died)

func start_enemy_turn():
	battleActionButtons.hide()
	var enemy = BattleUnits.Enemy
	if enemy != null and not enemy.is_queued_for_deletion():
		enemy.attack()
		await enemy.end_turn
	start_player_turn()

func start_player_turn():
	battleActionButtons.show()
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap = playerStats.max_ap
	await playerStats.end_turn
	start_enemy_turn()

func create_new_enemy():
	enemies.shuffle()
	var Enemy = enemies.front()
	var enemy = Enemy.instantiate()
	enemyPosition.add_child(enemy)
	enemy.died.connect(_on_enemy_died)

func _on_enemy_died():
	nextRoomButton.show()
	battleActionButtons.hide()


func _on_next_room_button_pressed():
	nextRoomButton.hide()
	animationPlayer.play("FadeToNewRoom")
	await animationPlayer.animation_finished
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap = playerStats.max_ap
	battleActionButtons.show()
	create_new_enemy()
