extends Node3D
@onready var ui = preload("res://Scene/ui.tscn").instantiate()

func _ready() -> void:
	add_child(ui)
	var select = $Control/Select
	select.connect('mouseover', mouseisover)
	pass

func mouseisover():
	print('mouse is over')


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if Globals.tails == true:
		$Control/CanvasLayer/HeadsL.visible = false
		$Control/CanvasLayer/TailsL.visible = true
	elif Globals.heads == true:
		$Control/CanvasLayer/HeadsL.visible = true
		$Control/CanvasLayer/TailsL.visible = false
	pass # Replace with function body.
