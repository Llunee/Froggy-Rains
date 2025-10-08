extends Node2D

@export var apple_scene: PackedScene
@export var puzzle_scene: PackedScene
@onready var apple_spawn_points = $AppleSpawns.get_children()
@onready var puzzle_spawn_points = $PuzzleSpawns.get_children()

func _ready() -> void:
	for apple_marker in apple_spawn_points:
		spawn_item(apple_marker.global_position, apple_scene)
	for puzzle_marker in puzzle_spawn_points:
		spawn_item(puzzle_marker.global_position, puzzle_scene)

func spawn_item(pos: Vector2, scene: PackedScene) -> void:
	var item = scene.instantiate()
	add_child(item)
	item.global_position = pos
	item.player = $player
	item.connect("collected", Callable(self, "_on_item_collected").bind(scene))

func _on_item_collected(pos: Vector2, scene: PackedScene) -> void:
	var timer = get_tree().create_timer(5.0)
	await timer.timeout
	spawn_item(pos, scene)
