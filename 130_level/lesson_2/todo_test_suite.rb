require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"

Minitest::Reporters.use!
require 'pry'

require_relative "todo"

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_done!
    assert(@todo1.done? == false)
    @todo1.done!
    assert(@todo1.done? == true)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(@list.size, 3)
  end

  def test_last
    assert_equal(@list.last, @todo3)
  end

  def test_shift
    assert_equal(@list.shift, @todo1)
    assert_equal(@list.shift, @todo2)
    assert_equal(@list.shift, @todo3)
    assert_nil(@list.shift)
  end

  def test_pop
    assert_equal(@list.pop, @todo3)
    assert_equal(@list.pop, @todo2)
    assert_equal(@list.pop, @todo1)
    assert_nil(@list.pop)
  end

  def test_all_done?
    todos_done = @todos.all? { |to_do| to_do.done?}
    assert_equal(@list.all_done?, todos_done)
  end

  def test_type_error_add_todo
    assert_raises(TypeError) { |x| @list.add "Hello" }
  end

  def test_shovel
    new_todo = Todo.new "Test TodoList#<<"

    @list << new_todo

    assert_equal(@list.to_a.count,4)
  end

  def test_item_at
    assert_raises(IndexError) { |_| @list.item_at 4}
  end

  def test_mark_done_at
    assert_raises(IndexError) { |_| @list.mark_done_at 4}
  end

  def test_mark_undone_at
    assert_raises(IndexError) { |_| @list.mark_undone_at 4}
  end

  def test_mark_all_done
    @list.mark_all_done

    assert( @list.to_a.all? { |to_do| to_do.done?})
  end

  def test_remove_at
    assert_raises(IndexError) { |_| @list.remove_at 4}
    assert_equal(@list.remove_at(1), @todo1)
    assert(@list.to_a.count == 2)
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym

    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_2
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym

    OUTPUT

    @list.mark_done_at 2

    assert_equal(output, @list.to_s)
  end

  def test_to_s_3
    output = <<~OUTPUT
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.mark_all_done

    assert_equal(output, @list.to_s)
  end

  def test_each
    arr = []
    @list.each { |to_do| arr << to_do }

    assert_equal(arr, @list.todos)
  end

  def test_each_return
    each_return_value = @list.each { |_| }

    assert_equal(@list, each_return_value)
  end

  def test_select
    select_return_value = @list.select { |_| true }

    assert_equal(select_return_value.to_a, @list.to_a)
    refute_equal(select_return_value.object_id, @list.object_id)
  end
end