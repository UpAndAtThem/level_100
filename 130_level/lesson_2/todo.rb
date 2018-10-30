require 'pry'

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

  def done!
    self.done = true
  end

  def undone!
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
    raise TypeError unless todo.class == Todo
    todos << todo
  end

  alias << add

  def size
    todos.size
  end

  def first
    todos.first
  end

  def all_done?
    todos.all?(&:done?)
  end

  def all_not_done?
    todos.all? { |to_do| !to_do.done? }
  end

  def mark_done(task_query)
    todos.each do |to_do|
      if to_do.task == task_query
        to_do.done!
        return nil
      end
    end
  end

  def mark_all_done
    todos.each(&:done!)
  end

  def mark_all_undone
    todos.each(&:undone!)
  end

  def mark_done_at(row)
    raise IndexError if todos[row - 1].nil?
    todos[row - 1].done!
  end

  def mark_undone_at(row)
    raise IndexError if todos[row - 1].nil?
    todos[row - 1].undone!
  end

  def last
    todos.last
  end

  def item_at(row)
    raise IndexError if todos[row - 1].nil?
    todos[row - 1]
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(row)
    raise IndexError if todos[row - 1].nil?
    todos.delete_at(row - 1)
  end

  def to_s
    todos.map { |todo| todo.to_s + "\n" }.join''
  end

  def to_a
    todos
  end

  def each
    todos.each { |to_do| yield to_do }
    self
  end

  def replace_at(row, new_task)
    raise TypeError unless row.class == Integer && new_task.class == String

    todos[row - 1] = Todo.new(new_task)
  end

  def select
    selected_todos = todos.select { |to_do| yield to_do }
    return_list = TodoList.new(name)

    selected_todos.each { |to_do| return_list.add to_do }

    return_list
  end

  def find_by_title(title_query)
    each { |to_do| return to_do if to_do.task == title_query }
  end
end

todo1 = Todo.new('Buy milk')
todo2 = Todo.new('Clean room')
todo3 = Todo.new('Go to gym')
list = TodoList.new('Today\'s Todos')

list << todo1
list.add todo2
list.add todo3

list.replace_at 2, 'Make List#replace_at method'

puts list
