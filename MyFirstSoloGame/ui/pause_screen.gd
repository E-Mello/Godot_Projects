extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("pause"):
		visible = true
		get_tree().paused = true
		
func _on_continue_pressed():
	visible = false
	get_tree().paused = false


func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/menu.tscn")
	queue_free()
