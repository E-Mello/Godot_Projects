extends Node2D

const BULLET_IMPACT =  preload("res://weapons/BulletImpact.tscn")


func _ready() -> void:
	GlobalSignals.connect("bullet_impact", self, "handle_bullet_impact")

func handle_bullet_impact(position: Vector2, direction: Vector2):
	var impact = BULLET_IMPACT.instance()
	add_child(impact)
	impact.global_position = position
	impact.global_position = direction.angle()
	impact.start_emitting()
