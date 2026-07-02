extends Control

class_name TierList

@onready var add_tier := %AddTier
@onready var tiers := %Tiers
@onready var grid_con := %GridContainer
@onready var tier_scene: PackedScene = preload("res://scenes/tier.tscn")
@onready var target_path := ProjectSettings.globalize_path("user://images")
@onready var tierlist_line_edit := %TierListNameEdit

var tierlist_name: String


func new_tier() -> void:
	var tier := tier_scene.instantiate()
	tiers.add_child(tier)


func add_starting_tiers() -> void:
	var s: int = Tier.TIER_LABELS.size()
	for t in range(s):
		new_tier()


func _ready() -> void:
	add_starting_tiers()
	if not DirAccess.dir_exists_absolute(target_path):
		DirAccess.make_dir_absolute(target_path)


func _on_add_tier_pressed() -> void:
	new_tier()


func _on_open_image_folder_pressed() -> void:
	OS.shell_open(target_path)


func _on_reload_pressed() -> void:
	grid_con.load_images_from_folder()


func _on_quit_pressed() -> void:
	get_tree().quit()


func save_tierlist(tl_name: String):
	if not tl_name:
		printerr("Filename cannot be empty.")
		return

	var tier_n := tiers.get_child_count()

	var save_dict: Dictionary = {
		"tierlist_name" = tl_name,
		"tier_count" = tier_n,
		"images" = [],
	}

	for tier in tiers.get_children():
		var tier_images = []
		for img in tier.get_node("%ContentBox").get_children():
			tier_images.append(img.get_path())

		save_dict["images"].append(tier_images)

	print(save_dict)


func _on_save_pressed() -> void:
	tierlist_name = tierlist_line_edit.text
	save_tierlist(tierlist_name)
