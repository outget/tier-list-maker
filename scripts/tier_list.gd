extends Control

class_name TierList

@onready var add_tier := %AddTier
@onready var tiers := %Tiers
@onready var grid_con := %GridContainer
@onready var tier_scene: PackedScene = preload("res://scenes/tier.tscn")
@onready var target_path := ProjectSettings.globalize_path("user://images")


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
