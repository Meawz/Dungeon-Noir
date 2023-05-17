extends Node2D

var BattleUnits = preload("res://BattleUnits.tres")

@onready var hpLabel = $HPLabel
@onready var animationPlayer = $AnimationPlayer

signal died
signal end_turn

@export var hp: int = 25:
	set(new_hp):
		hp = new_hp
		if hpLabel != null:
			hpLabel.text = str(hp)+"hp"

@export var Damage: int = 4

func _ready():
	BattleUnits.Enemy = self

func _exit_tree():
	BattleUnits.Enemy = null

func attack() -> void:
	await get_tree().create_timer(0.4).timeout
	animationPlayer.play("Attack")
	await animationPlayer.animation_finished
	emit_signal("end_turn")

func deal_damage():
	BattleUnits.PlayerStats.hp -= Damage

func take_damage(amount):
	self.hp -= amount
	if is_dead():
		emit_signal("died")
		queue_free()
	else:
		animationPlayer.play("Shake")

func is_dead():
	return hp <= 0
