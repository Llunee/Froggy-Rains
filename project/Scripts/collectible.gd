extends Area2D

@export var item: InventoryItem
var player

signal collected(position: Vector2)

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body == player:
		player.collect(item)
		emit_signal("collected", global_position)
		await get_tree().create_timer(0.1).timeout 
		self.queue_free()
