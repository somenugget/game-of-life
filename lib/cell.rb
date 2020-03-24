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

  def will_be_alive_with_neighbours!(neighbours)
    alive_neighbours_count = neighbours.select(&:alive?).count

    if alive?
      @will_be_alive = false unless (2..3).include? alive_neighbours_count
    elsif alive_neighbours_count == 3
      @will_be_alive = true
    end
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
