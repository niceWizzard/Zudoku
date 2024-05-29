extends GutTest

const MainScene := preload("res://main.gd")

var main_instance : MainScene


func before_all():
	gut.p("Instantiating the main.tscn")
	var main_scene = load("res://main.tscn")
	main_instance = main_scene.instantiate()
	get_tree().root.add_child(main_instance)
	wait_seconds(0.1)
	assert_eq(main_instance.main_grid.get_child_count(), 9)

func test_grid_values():
	gut.p("Testing for (3,0)")
	var c1 = main_instance.tile_view_map.get_tile(3,0)
	var tileInChildren := get_tile_from_main(1,0)
	assert_eq(c1, tileInChildren)

	gut.p("Testing for (2,5)")
	var c2 = main_instance.tile_view_map.get_tile(2,5)
	assert_eq(c2,get_tile_from_main(3,8))

	gut.p("Testing for (7,0)")
	var c3 = main_instance.tile_view_map.get_tile(7,0)
	assert_eq(c3,get_tile_from_main(2,1))

	gut.p("Testinf for (4,4)")
	assert_eq(
		main_instance.tile_view_map.get_tile(4,4),
		get_tile_from_main(4,4)
	)


func get_tile_from_main(x:int,y:int) -> TileView:
	return main_instance.main_grid.get_children()[x].get_children()[y]


	
