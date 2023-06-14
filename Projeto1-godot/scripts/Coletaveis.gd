extends Node2D

var Cherry = preload("res://objects/cherry.tscn")


func _on_timer_timeout():
	var CherryTemp = Cherry.instantiate()
	var rng = RandomNumberGenerator.new()
	var randint = rng.randi_range(90, 540)
	CherryTemp.position = Vector2(randint, 510)
	get_node("Cerejas").add_child(CherryTemp)
