extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/itemDisplay
@onready var item_amount: Label = $CenterContainer/Panel/amountLabel

func update(slot: InventorySlot):
	if slot.item == null:
		item_visual.visible = false
		item_amount.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		item_amount.visible = true
		item_amount.text = str(slot.amount) if slot.amount > 1 else ""
