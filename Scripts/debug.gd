extends PanelContainer
@onready var prop_container:VBoxContainer = $MarginContainer/VBoxContainer
var property
var fps:String
func _ready() -> void:
	Global.debug = self	
	visible = true
	add_debug_prop("FPS", fps, 1)

func _process(delta: float) -> void:
	fps = "%.2f" % (1.0/delta)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_toggle"):
		visible = !visible

func add_debug_prop(title: String, value, order):
	var target
	target = prop_container.find_child(title, true, false)
	if !target:
		target = Label.new()
		prop_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible:
		target.text = title + ": " + str(value)
		prop_container.move_child(target, order)
#func add_debug_prop(title: String, value):
	#property = Label.new()
	#prop_container.add_child(property)
	#property.name = title
	#property.text = property.name + value
