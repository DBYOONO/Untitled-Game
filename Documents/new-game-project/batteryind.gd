extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
@onready var info = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = str("BATTERY: ", snapped(info.battery,1))
	if info.flashlight.visible == true:
		visible = true
	else:
		visible = false
	
