extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true


func _on_continue_pressed():
	get_tree().paused = false
	queue_free()

func _on_main_menu_pressed():
	get_tree().paused = false
	queue_free()
	get_tree().change_scene_to_file("res://ui/menu.tscn")
