extends Resource

class_name Inventory

signal update_inventory

@export var slots: Array[InventorySlot]


func insert(item: InventoryItem):
	var item_slots = slots.filter(func(slot): return slot != null and slot.item == item)
	var empty_slots = slots.filter(func(slot): return slot.item == null)
	
	if item_slots.is_empty() and !empty_slots.is_empty():
		empty_slots[0].item = item
		empty_slots[0].amount += 1
		
	for item_slot in item_slots:
		if item_slot.amount >= 99:
			continue
		else:
			item_slot.amount += 1
			break
	
	update_inventory.emit()
	
