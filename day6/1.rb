
ALL_THE_FISH = []

class Simulation

  def initialize(initial_state)
    @initial_state = initial_state
    @day = 0
  end

  def spawn_fish
    @initial_state.split(",").each do |timer|
      ALL_THE_FISH << LaternFish.new(timer)
    end
  end

  def next_day!
    @day += 1
    ALL_THE_FISH.each{|f| f.tick}
  end

  def daily_report
    # "Day#{@day}: #{ALL_THE_FISH.map(&:timer).join(",")}"
    "Day#{@day}: Size => #{ALL_THE_FISH.size}"
  end

  def run_for_days(number_of_days)
    0.upto(number_of_days).each do
      puts daily_report
      next_day!
    end
  end
end

class LaternFish 
  def initialize(timer)
    @timer = timer.to_i
  end

  def timer
    @timer
  end

  def tick
    if @timer == 0
      spawn_another_fish
      reset_timer
    end
    @timer -= 1
  end

  def spawn_another_fish
    ALL_THE_FISH << LaternFish.new(9)
  end

  def reset_timer
    @timer = 7
  end
end

init = File.read('input.txt')

sim = Simulation.new(init)
sim.spawn_fish
sim.run_for_days(256)