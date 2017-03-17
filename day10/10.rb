class Bot

  attr_reader :name, :chips

  def initialize(name)
    @name = name
    @chips = []
  end

  def take_high
    @chips.delete(@chips.max)
  end

  def take_low
    @chips.delete(@chips.min)
  end

  def give(chip)
    @chips << chip
  end
end

Output = Struct.new(:name, :chip)
Transaction = Struct.new(:giver, :low_type, :low_taker, :high_type, :high_taker)

bots = Hash.new
transactions = Hash.new
outputs = Hash.new

File.readlines("10.input").each do |line|
  if line.start_with?("value")
    name = line.split(" ").last.to_i
    chip = line.split(" ")[1].to_i

    bots[name] = Bot.new(name) unless bots[name]
    bots[name].give(chip)
  elsif line.start_with?("bot")
    giver = line.split(" ")[1].to_i
    low_type = line.split(" ")[5]
    low_taker = line.split(" ")[6].to_i
    high_type = line.split(" ")[10]
    high_taker = line.split(" ")[11].to_i

    transactions[giver] = Transaction.new(giver, low_type, low_taker, high_type, high_taker)

    if low_type == "bot"
      bots[low_taker] = Bot.new(low_taker) unless bots[low_taker]
    else
      outputs[low_taker] = Output.new(low_taker)
    end

    if high_type == "bot"
      bots[high_taker] = Bot.new(high_taker) unless bots[high_taker]
    else
      outputs[high_taker] = Output.new(high_taker)
    end
  end
end

until transactions.empty? do
  givers = bots.select { |id, bot| bot.chips.size == 2 }

  if givers.empty?
    break
  end

  givers.each do |giver_name, giver|
    if giver.chips.include?(61) && giver.chips.include?(17)
      puts "Part 1: Bot comparing chip 61 and chip 17: Bot #{giver_name}"
    end

    # remove from list of givers since we only give once
    bots.delete(giver_name)

    # perform transaction
    t = transactions.delete(giver_name)

    if t.low_type == "bot"
      bots[t.low_taker].give(giver.take_low)
    else
      outputs[t.low_taker].chip = giver.take_low
    end

    if t.high_type == "bot"
      bots[t.high_taker].give(giver.take_high)
    else
      outputs[t.high_taker].chip = giver.take_high
    end
  end
end

puts "Part 2: Multiplying chips of output 1,2,3: #{outputs[0].chip * outputs[1].chip * outputs[2].chip}"
