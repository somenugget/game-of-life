require_relative '../lib/grid'

RSpec.describe Grid do
  describe 'glider' do
    subject(:grid) do
      described_class.new(
        height: 5,
        width: 5,
        cells_alive: [[0, 2], [1, 0], [1, 2], [2, 1], [2, 2]]
      )
    end

    let(:glider_steps) do
      [
        ".  .  🙂 .  . \n🙂 .  🙂 .  . \n.  🙂 🙂 .  . \n.  .  .  .  . \n.  .  .  .  . ",
        ".  🙂 .  .  . \n.  .  🙂 🙂 . \n.  🙂 🙂 .  . \n.  .  .  .  . \n.  .  .  .  . ",
        ".  .  🙂 .  . \n.  .  .  🙂 . \n.  🙂 🙂 🙂 . \n.  .  .  .  . \n.  .  .  .  . ",
        ".  .  .  .  . \n.  🙂 .  🙂 . \n.  .  🙂 🙂 . \n.  .  🙂 .  . \n.  .  .  .  . ",
        ".  .  .  .  . \n.  .  .  🙂 . \n.  🙂 .  🙂 . \n.  .  🙂 🙂 . \n.  .  .  .  . ",
        ".  .  .  .  . \n.  .  🙂 .  . \n.  .  .  🙂 🙂\n.  .  🙂 🙂 . \n.  .  .  .  . ",
        ".  .  .  .  . \n.  .  .  🙂 . \n.  .  .  .  🙂\n.  .  🙂 🙂 🙂\n.  .  .  .  . ",
        ".  .  .  .  . \n.  .  .  .  . \n.  .  🙂 .  🙂\n.  .  .  🙂 🙂\n.  .  .  🙂 . ",
        ".  .  .  .  . \n.  .  .  .  . \n.  .  .  .  🙂\n.  .  🙂 .  🙂\n.  .  .  🙂 🙂",
        ".  .  .  .  . \n.  .  .  .  . \n.  .  .  🙂 . \n🙂 .  .  .  🙂\n.  .  .  🙂 🙂",
        ".  .  .  .  . \n.  .  .  .  . \n.  .  .  .  🙂\n🙂 .  .  .  . \n🙂 .  .  🙂 🙂",
        ".  .  .  .  🙂\n.  .  .  .  . \n.  .  .  .  . \n🙂 .  .  🙂 . \n🙂 .  .  .  🙂",
        "🙂 .  .  .  🙂\n.  .  .  .  . \n.  .  .  .  . \n🙂 .  .  .  . \n🙂 .  .  🙂 . ",
        "🙂 .  .  .  🙂\n.  .  .  .  . \n.  .  .  .  . \n.  .  .  .  🙂\n🙂 🙂 .  .  . ",
        "🙂 🙂 .  .  🙂\n.  .  .  .  . \n.  .  .  .  . \n🙂 .  .  .  . \n.  🙂 .  .  . ",
        "🙂 🙂 .  .  . \n🙂 .  .  .  . \n.  .  .  .  . \n.  .  .  .  . \n.  🙂 .  .  🙂",
        ".  🙂 .  .  🙂\n🙂 🙂 .  .  . \n.  .  .  .  . \n.  .  .  .  . \n.  🙂 .  .  . ",
        ".  🙂 🙂 .  . \n🙂 🙂 .  .  . \n.  .  .  .  . \n.  .  .  .  . \n🙂 .  .  .  . ",
        ".  .  🙂 .  . \n🙂 🙂 🙂 .  . \n.  .  .  .  . \n.  .  .  .  . \n.  🙂 .  .  . ",
        "🙂 .  🙂 .  . \n.  🙂 🙂 .  . \n.  🙂 .  .  . \n.  .  .  .  . \n.  .  .  .  . ",
        ".  .  🙂 .  . \n🙂 .  🙂 .  . \n.  🙂 🙂 .  . \n.  .  .  .  . \n.  .  .  .  . "
      ]
    end

    it 'renders all glider\'s steps' do
      glider_steps.each_with_index do |grid_snapshot, step|
        expect(grid.to_s).to(
          eq(grid_snapshot),
          "Snapshot mismatch on the step #{step}.\nExpected #{grid_snapshot.inspect}.\nGot      #{grid.to_s.inspect}"
        )

        grid.evolve
      end
    end
  end
end
