extends Control


export(PackedScene) var cpu_scene
export(PackedScene) var player_scene


func _on_ButtonCPU_pressed():
	get_tree().change_scene_to(cpu_scene)


func _on_Button2P_pressed():
	get_tree().change_scene_to(player_scene)
