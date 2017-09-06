require_relative 'db_connection'
require_relative 'searchable'
require_relative 'associatable'
require 'active_support/inflector' # using: 'string'.tablelize
require 'byebug'

class SQLObject

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= (self.to_s).tableize
  end

  def self.columns
    @full_table ||= DBConnection.execute2(<<-SQL)
      SELECT *
      FROM "#{self.table_name}"
    SQL
    # nil
    @full_table.first.map(&:to_sym)
  end

  def attributes
    @attributes ||= {}
  end

  def self.finalize!
    self.columns.each do |col_name|
      define_method(col_name) {self.attributes[col_name]}
      define_method("#{col_name}=") {|val| self.attributes[col_name] = val }
    end
  end

  def self.all
    full_table = DBConnection.execute("SELECT #{self.table_name}.* FROM #{self.table_name}")
    self.parse_all(full_table)
  end

  def self.parse_all(results)
    class_objects = []
    results.each do |hash|
      class_objects << self.new(hash)
    end
    class_objects
  end

  def self.find(id)
    found = DBConnection.execute(<<-SQL, id)
      SELECT #{self.table_name}.*
      FROM #{self.table_name}
      WHERE #{self.table_name}.id = ?
    SQL
    return self.new(found.first) if found.length > 0
    nil
  end

  def initialize(params = {})
    params.each do |attr_name, val|
      if (self.class).columns.include?(attr_name.to_sym)
        self.send("#{attr_name}=", val)
      else
        raise Exception.new("unknown attribute '#{attr_name}'")
      end
    end
  end


  def attribute_values
    self.class.columns.map { |col_name| self.send("#{col_name}")}
  end

  def save
    if self.id == nil
      self.insert
    else
      self.update
    end
  end

  # private
  def insert
    col_names = self.class.columns
    question_marks = Array.new()
    col_names.length.times do
      question_marks << "?"
    end
    col_names = "(#{col_names.join(", ")})"
    question_marks = "(#{question_marks.join(", ")})"

    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} #{col_names}
      VALUES
        #{question_marks}
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    col_names = self.class.columns.reject {|el| el == :id}
    set_line = col_names.map { |attr_name| "#{attr_name} = ?" }.join(", ")
    attr_vals = col_names.map { |col_name| self.send("#{col_name}")}
    DBConnection.execute(<<-SQL, *attr_vals, self.id)
      UPDATE #{self.class.table_name}
      SET #{set_line}
      WHERE id = ?
    SQL
  end

end
