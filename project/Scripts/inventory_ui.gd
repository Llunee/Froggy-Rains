extends Control

@onready var inventory: Inventory = preload("res://resources/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false


func _ready() -> void:
	inventory.connect("update_inventory", Callable(self, "update_slots"))
	update_slots()
	close()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()


func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])


func open():
	visible = true
	is_open = true
	

func close():
	visible = false
	is_open = false
