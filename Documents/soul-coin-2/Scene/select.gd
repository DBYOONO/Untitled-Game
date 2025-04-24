extends Node3D

@onready var NZ50 = $Select/OPH/RigidBody3D2/Area3D
signal mouseover
func _ready() -> void:
	pass
	



func _on_area_3d_mouse_entered(NZ50) -> void:
	print('mouseover')
	emit_signal("mouseover")
	pass # Replace with function body.
