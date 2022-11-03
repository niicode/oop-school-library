require_relative 'nameable'

class Decorator < Nameable
  attr_accessor :nameable

  def initialize(nameable)
    super
    @namable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end
