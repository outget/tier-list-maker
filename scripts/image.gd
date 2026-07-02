extends Control

@onready var texture_rect = %TextureRect


func set_image_properties() -> void:
	texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture_rect.custom_maximum_size = Vector2(50, 50)
	texture_rect.custom_minimum_size = Vector2(50, 50)
	self.custom_maximum_size = Vector2(50, 50)
	self.custom_minimum_size = Vector2(50, 50)


func _get_drag_data(_at_position: Vector2) -> Variant:
	var prev = TextureRect.new()
	prev.texture = texture_rect.texture
	prev.custom_minimum_size = Vector2(50, 50)
	prev.custom_maximum_size = Vector2(50, 50)

	set_drag_preview(prev)

	return self


func is_draggable_item() -> bool:
	return true
