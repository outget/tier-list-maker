extends HBoxContainer

class_name Tier

@onready var tier_text := %LineEdit
@onready var icon := %Icon
@onready var stylebox = icon.get_theme_stylebox("panel") as StyleBoxFlat

const TIER_LABELS: PackedStringArray = [
	"S",
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
]

static var TIER_COLORS: PackedColorArray = [
	Color.from_rgba8(255, 127, 127),
	Color.from_rgba8(255, 191, 127),
	Color.from_rgba8(255, 223, 127),
	Color.from_rgba8(255, 255, 127),
	Color.from_rgba8(191, 255, 127),
	Color.from_rgba8(150, 255, 127),
	Color.from_rgba8(36, 255, 127, 255),
]


func get_tier_label() -> String:
	var depth := get_index()
	if depth >= TIER_LABELS.size():
		return TIER_LABELS[TIER_LABELS.size() - 1]
	else:
		return TIER_LABELS[depth]


func get_tier_color() -> Color:
	var depth := get_index()
	if depth >= TIER_COLORS.size():
		return TIER_COLORS[TIER_COLORS.size() - 1]
	else:
		return TIER_COLORS[depth]


func _ready() -> void:
	tier_text.text = get_tier_label()
	stylebox.bg_color = get_tier_color()
	add_theme_stylebox_override("panel", stylebox)


func _on_delete_pressed() -> void:
	queue_free()


func _on_line_edit_editing_toggled(toggled_on: bool) -> void:
	if toggled_on:
		tier_text.text = ""
	else:
		tier_text.text = tier_text.text.strip_edges()
		if tier_text.text == "":
			tier_text.text = get_tier_label()


func _on_line_edit_text_submitted(new_text: String) -> void:
	tier_text.text = new_text.strip_edges()
	if tier_text.text == "":
		tier_text.text = get_tier_label()


func _on_up_pressed() -> void:
	var parent := get_parent()
	var current_idx := get_index()
	parent.move_child(self, max(0, current_idx - 1))


func _on_down_pressed() -> void:
	var parent := get_parent()
	var current_idx := get_index()
	parent.move_child(self, max(0, current_idx + 1))
