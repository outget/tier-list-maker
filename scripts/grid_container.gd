extends GridContainer

@onready var img_scene: PackedScene = preload("res://scenes/image.tscn")

var img_pool: PackedStringArray


func _ready() -> void:
	load_images_from_folder()


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_OBJECT and data.has_method("is_draggable_item")


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	data.get_parent().remove_child(data)
	self.add_child(data)
	data.set_image_properties()


func load_images_from_folder() -> void:
	var folder_path := "user://images/"
	var dir := DirAccess.open(folder_path)
	if not dir:
		DirAccess.make_dir_absolute(folder_path)
	dir = DirAccess.open(folder_path)
	assert(dir, "Failed to open images folder.")

	var files: PackedStringArray = dir.get_files()

	var valid_ext = ["png", "jpg", "jpeg", "webp", "svg"]

	for file in files:
		var ext := file.get_extension().to_lower()
		if ext in valid_ext and file not in img_pool:
			img_pool.append(file)
			var img = img_scene.instantiate()
			add_child(img)
			var real_img = Image.load_from_file(folder_path + file)
			img.get_node("%TextureRect").texture = ImageTexture.create_from_image(real_img)
			img.set_image_properties()
