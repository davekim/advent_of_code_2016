class Bot
  attr_reader :name, :chips

  def initialize(name)
    @name = name
    @chips = []
  end

  def take_high!
    @chips.delete(@chips.max)
  end

  def take_low!
    @chips.delete(@chips.min)
  end

  def give(chip)
    @chips << chip
  end
end

Output = Struct.new(:name, :chip)
Transaction = Struct.new(:giver, :low_type, :low_name, :high_type, :high_name)

class Inspector
  attr_reader :outputs

  def initialize
    @bots = Hash.new
    @transactions = Hash.new
    @outputs = Hash.new
  end

  def add_bot(name, chip)
    _add_or_create_bot(name)
    @bots[name].give(chip.to_i)
  end

  def add_transaction(giver, low_type, low_name, high_type, high_name)
    @transactions[giver] = Transaction.new(giver, low_type, low_name, high_type, high_name)
    _add_bot_or_output(low_type, low_name)
    _add_bot_or_output(high_type, high_name)
  end

  def _add_bot_or_output(type, name)
    if type == "bot"
      _add_or_create_bot(name)
    else
      @outputs[name] = Output.new(name)
    end
  end

  def _add_or_create_bot(name)
    @bots[name] = Bot.new(name) unless @bots[name]
  end

  def inspect!
    until @transactions.empty? do
      givers = @bots.select { |id, bot| bot.chips.size == 2 }

      if givers.empty?
        break
      end

      givers.each do |giver_name, giver|
        if giver.chips.include?(61) && giver.chips.include?(17)
          puts "Part 1: Bot comparing chip 61 and chip 17: Bot #{giver_name}"
        end

        # remove from list of givers since we only give once
        @bots.delete(giver_name)

        # perform transaction
        t = @transactions.delete(giver_name)
        _give(t.low_type, giver.take_low!, t.low_name)
        _give(t.high_type, giver.take_high!, t.high_name)
      end
    end
  end

  def _give(type, chip, name)
    if type == "bot"
      @bots[name].give(chip)
    else
      @outputs[name].chip = chip
    end
  end
end


VALUE_LINE = /value (\d+) goes to bot (\d+)/
TRANSACTION_LINE = /bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)/

inspector = Inspector.new

File.readlines("10.input").each do |line|
  if line.start_with?("value")
    chip, name = line.match(VALUE_LINE).captures
    inspector.add_bot(name, chip)
  elsif line.start_with?("bot")
    giver, low_type, low_name, high_type, high_name = line.match(TRANSACTION_LINE).captures
    inspector.add_transaction(giver, low_type, low_name, high_type, high_name)
  end
end

inspector.inspect!

puts "Part 2: Multiplying chips of output 1,2,3: #{inspector.outputs["0"].chip * inspector.outputs["1"].chip * inspector.outputs["2"].chip}"
