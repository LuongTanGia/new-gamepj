extends Area2D

@export var health_component: HealthComponent

func damage(amount: float) -> void:
  if health_component:
    health_component.take_damage(amount)