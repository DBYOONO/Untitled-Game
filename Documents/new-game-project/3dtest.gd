extends Node3D

@onready var raycast = $CharacterBody3D/Neck/Camera3D/Aimray
@onready var b_decal = load("res://b_decal.tscn")
@onready var hitpart = $Hitpart
@onready var aim_ray = $CharacterBody3D/Neck/Camera3D/Aimray
@onready var barrel = $CharacterBody3D/Neck/Camera3D/Gun/Barrel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@onready var hitpart2 = $GPUParticles3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
func hitpartfunc():
	hitpart.restart()
	hitpart.global_position = aim_ray.get_collision_point()
	hitpart.look_at(barrel.global_position)
