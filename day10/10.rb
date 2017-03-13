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

class Transaction
  attr_reader :giver, :low_taker, :high_taker

  def initialize(giver, low_taker, high_taker)
    @giver = giver
    @low_taker = low_taker
    @high_taker = high_taker
  end
end

bots = Hash.new
transactions = Hash.new

File.readlines("10.input").each do |line|
  if line.start_with?("value")
    name = line.split(" ").last.to_i
    chip = line.split(" ")[1].to_i

    bots[name] = Bot.new(name) unless bots[name]
    bots[name].give(chip)
  elsif line.start_with?("bot")
    giver = line.split(" ")[1].to_i
    low_taker = line.split(" ")[6].to_i
    high_taker = line.split(" ")[11].to_i

    transactions[giver] = Transaction.new(giver, low_taker, high_taker)

    bots[low_taker] = Bot.new(low_taker) unless bots[low_taker]
    bots[high_taker] = Bot.new(high_taker) unless bots[high_taker]
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
    bots[t.low_taker].give(giver.take_low)
    bots[t.high_taker].give(giver.take_high)
  end
end
