extends CharacterBody3D


var player = null
var state_machine

const SPEED = 4.0
const ATTACK_RANGE = 2.0




# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
@onready var info = $CharacterBody3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
