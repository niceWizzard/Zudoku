extends GutTest


var bindable : Bindable

func before_each() -> void:
    bindable = Bindable.new()

func test_reflect_to_bindings() -> void:
    var node := Node.new()
    bindable.bind(node, "name")
    assert_true(bindable.binded_nodes.size() == 1)
    assert_true(bindable.binded_nodes[0][1] == "name")

    bindable._reflect_to_bindings("hello")
    assert_eq(node.name, "hello")
    node.free()

func test_bind() -> void:
    var node := Node.new()
    bindable.bind(node, "name")
    assert_eq(bindable.binded_nodes.size(), 1)
    assert_eq(bindable.binded_nodes[0][1], "name")

    node.free()



