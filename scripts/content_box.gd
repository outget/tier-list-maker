extends HBoxContainer

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_OBJECT and data.has_method("is_draggable_item")


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	data.get_parent().remove_child(data)
	self.add_child(data)
	data.set_image_properties()
