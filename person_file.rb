# frozen_string_literal: true

class Person
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name, parent_permission: true)
    super()
    @id = Random.rand(1..100)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    name
  end

  private

  def of_age?
    age >= 18
  end
end
