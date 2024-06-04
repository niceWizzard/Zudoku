extends GutTest


var bindable : IntBindable

func before_each() -> void:
    bindable = IntBindable.new()

func test_set_value() -> void:
    var nodes : Array[Label] = []
    for i in range(10):
        var n := Label.new()
        nodes.append(n)
        bindable.bind(n, "text")

    bindable.value = 1

    for i in nodes:
        assert_eq(i.text, "1", "Label text should be 1")
    
    bindable.value = 20
    for i in nodes:
            assert_eq(i.text, "20", "Label text should be 20")

    for i in nodes:
        i.free()

func test_bind_with_transformer() -> void:
    var label := Label.new()
    bindable.bind_transform(label, "text", func(a: int) -> String: return "a: %s" % a)

    bindable.value = 20
    assert_eq(label.text, "a: 20")

    label.free()

func test_bind() -> void:
    var node := Node.new()
    bindable.bind(node, "name")
    assert_eq(bindable.binded_nodes.size(), 1)
    assert_eq(bindable.binded_nodes[0][1], "name")
    node.free()



