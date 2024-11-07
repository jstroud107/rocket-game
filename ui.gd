extends CanvasLayer

static var image = load("res://damage_jet.png")
var time_elapsed := 0

func set_health(amount):
	# remove all children
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()
	# create new children amount is set by health
	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		$MarginContainer2/HBoxContainer.add_child(text_rect)
		text_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL


func _on_score_timer_timeout() -> void:
	time_elapsed += 1
	$MarginContainer/Label.text = str(time_elapsed)
	Global.score = time_elapsed
