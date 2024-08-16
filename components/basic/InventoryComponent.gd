extends Node
class_name InventoryComponent

var equipped_item: Item
var items: Array[Item] = []
const MAX_SIZE = 7

func equit_item(index: int) -> Item:
	if not items[index]:
		return null
		
	equipped_item = items[index]
	return equipped_item

func unequip_item() -> void:
	equipped_item = null

func add_item(item: Item) -> int:
	if items.size() >= MAX_SIZE:
		printerr("You can't take more items")
		return -1

	items.append(item)
	return items.size()

func remove_item(index: int) -> void:
	items.remove_at(index)
