extends Node
class_name SaveManager

signal StartSaving(resource)
signal FinishedSaving

@export_enum("tres", "res") var file_extension = "res"

var registered_resources = []
var loaded_files = {}

func _ready() -> void:
	DirAccess.make_dir_absolute("user://save")
	return

func load() -> void:
	var save_files = DirAccess.get_files_at("user://save/")
	for file in save_files:
		var resource = ResourceLoader.load("user://save/%s" % [file])
		loaded_files[file.trim_suffix(".tres").trim_suffix(".res")] = resource
	FinishedSaving.emit()
	return

func register(resource_saver: Callable) -> void:
	if not resource_saver in registered_resources:
		assert(typeof(resource_saver) == TYPE_CALLABLE)
		print("Registered")
		registered_resources.append(resource_saver)
	return

func save() -> void:
	# Call all registered Callables in the Array and save the returns in another array.
	for callable in registered_resources:
		var resource = callable.call()
		if not resource[1] is Resource: # Check if the value in the array is an Object (aka Resource).
			continue
		ResourceSaver.save(resource[1], "user://save/%s" % [resource[0]+file_extension])
