extends PanelContainer

@onready var stylebox = get_theme_stylebox("panel") as StyleBoxFlat


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE and event.pressed:
			var color_picker_node: ColorPicker = ColorPicker.new()
			var popup: Popup = PopupPanel.new()
			popup.add_child(color_picker_node)
			add_child(popup)

			popup.position = get_global_mouse_position()

			popup.popup()

			color_picker_node.color_changed.connect(_on_color_changed)

			popup.close_requested.connect(popup.queue_free)
			accept_event()


func _on_color_changed(cl: Color):
	stylebox.bg_color = cl
	add_theme_stylebox_override("panel", stylebox)
