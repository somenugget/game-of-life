require 'dry-initializer'

class Cell
  extend Dry::Initializer

  option :alive, default: proc { false }

  alias alive? alive

  attr_reader :will_be_alive

  def live!
    @alive = true
  end

  def dead?
    !alive?
  end

  def will_be_alive!(value = true)
    @will_be_alive = value
  end

  def apply_changes!
    return if @will_be_alive.nil?

    @alive = @will_be_alive
    @will_be_alive = nil
  end

  def to_s
    alive? ? '🙂' : '. '
  end
end
