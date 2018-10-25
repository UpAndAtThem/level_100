# class Todo
class Todo
  DONE_MARK = 'X'.freeze
  NOT_DONE_MARK = ' '.freeze

  attr_accessor :done, :task

  def initialize(task, description = '')
    @task = task
    @description = description
    @done = false
  end

  def done?
    done
  end

  def mark_done!
    self.done = true
  end

  def mark_undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARK : NOT_DONE_MARK}] #{task}"
  end
end

# class TodoList
class TodoList
  attr_accessor :name, :todos

  def initialize(list_name)
    @name = list_name
    @todos = []
  end

  def add(todo)
    todos << todo if todo.class == Todo
  end

  def size
    todos.size
  end

  def first
    todos.first
  end

  def done?
    todos.all?(&:done)
  end

  def last
    todos.last
  end

  def item_at(row)
    todos[row - 1]
  end

  def mark_done_at(row)
    todos[row - 1].mark_done!
  end

  def mark_undone_at(row)
    todos[row - 1].mark_undone!
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(row)
    todos.delete_at(row - 1)
  end

  def to_s
    todos.map { |todo| todo.to_s + "\n" }.join''
  end
end

todo1 = Todo.new('Buy milk')
todo2 = Todo.new('Clean room')
todo3 = Todo.new('Go to gym')
list = TodoList.new("Today's Todos")

list.add todo1
list.add todo2
list.add todo3

puts list
